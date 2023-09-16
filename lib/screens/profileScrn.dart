import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:liviso_flutter/models/profile_data.dart';
import 'package:liviso_flutter/screens/homeScrn.dart';
import 'package:liviso_flutter/screens/login.dart';
import 'package:liviso_flutter/utils/colors.dart';
import 'package:liviso_flutter/widgets/bottom_navigation.dart';
import 'package:liviso_flutter/widgets/homeWidgets.dart';
import 'package:http/http.dart' as http;
import 'package:liviso_flutter/widgets/loginWidgets.dart';
import 'package:liviso_flutter/widgets/profileWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ProfileScreen extends StatefulWidget {
  final String user_id;
  const ProfileScreen({  required this.user_id, Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int selectedIndex =2;


  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });

    if(selectedIndex == 0){
      Navigator.of(context).push(
                           MaterialPageRoute(
                            builder: (context) => HomeScreen1(id : widget.user_id,),
                           ));
    }
    else if(selectedIndex == 2){
     Navigator.of(context).push(
                           MaterialPageRoute(
                            builder: (context) => ProfileScreen(user_id : widget.user_id,),
                           ));
    }
    else{
      return;
    }
  }


  Future<void> onSave(String editedText, String param) async {
    try {
         final response = await http.post(
                        Uri.parse(
                            'https://stealth-zys3.onrender.com/api/v1/auth/profile/${widget.user_id}'), 
                        body: {
                          param : editedText,
                        },
                      );

                      if (response.statusCode == 200) {
                        print("Value CHANGED");
                        setState(() {
                          profileData = fetchProfileData();
                        });
                      } else {
                        print("SOME ERROR");
                      }
                    } catch (error) {
                      print('eXCEPTION');
     }
  }

  late Future<ProfileData> profileData; 
  
  Future<ProfileData> fetchProfileData() async {
  final response = await http.get(Uri.parse('https://stealth-zys3.onrender.com/api/v1/auth/getProfile/${widget.user_id}')); 
  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    return ProfileData.fromJson(data["user"]);
  } else {
    throw Exception('Failed to load profile data');
  }
}

  @override
  void initState() {
    super.initState();
    print(widget.user_id);
    profileData = fetchProfileData(); 
  }

  Future _logout() async{
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove('userId');
    Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => LoginScreen(),
            ),

          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title : Text("Profile",
        style : GoogleFonts.poppins(
          textStyle: TextStyle(fontSize: 18.sp,
          color: ThemeColors.textColor9)
        )),
        titleSpacing: -10.w,
        elevation: sqrt1_2,
      ),
      body: SafeArea(
        child: FutureBuilder<ProfileData>(
          future: profileData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // While waiting for the API response, show a loading indicator
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              // If an error occurs during the API call, display an error message
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData) {
              // If no data is available, you can display an appropriate message
              return Text('No profile data available.');
            } else {
              // If data is available, display it using your ProfileWidget
              final profile = snapshot.data!;

              return Container(
                color: ThemeColors.backgroundColor,
                padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child:  SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                    
                          
                          SizedBox(height: 30),
                          ProfileWidget(label: 'Name',param : 'name' ,initialValue: profile.name,isShopLink: false, id : widget.user_id,onSave: onSave,),
                          ProfileWidget(label: 'Phone', param : 'phone', initialValue: profile.phone,isShopLink: false,id : widget.user_id,onSave: onSave),
                    
                          ProfileWidget(label: 'Email', param : 'email', initialValue: profile.email,isShopLink: false,id : widget.user_id,onSave: onSave),
                          ProfileWidget(label: 'Shop Name', param : 'shopName', initialValue: profile.shopName,isShopLink: false,id : widget.user_id,onSave: onSave),
                          ProfileWidget(label: 'Website Link', param : 'webLink',initialValue: profile.webLink,isShopLink: false,id : widget.user_id,onSave: onSave),
                          ProfileWidget(label: 'Social Media Link',param : 'socialLink', initialValue: profile.socialLink,isShopLink: false,id : widget.user_id,onSave: onSave),

                          ProfileWidget(label: 'Shop Link',param :'shopLink' ,initialValue: profile.shopLink,isShopLink: true,id : widget.user_id,onSave: onSave),
                            
                          SizedBox(height: 30),
                          ButtonMain(enabled: true, label: "Logout", onPressed: _logout)
                          
                        
                          
                          
                                    ],
                      ),
                    ),
                  
                ),
              );
            }
          },
        ),
      ),
      bottomNavigationBar: MyBottomNavigationBar(selectedIndex: selectedIndex,
      onItemTapped: _onItemTapped
      ),
    );
  }
}
