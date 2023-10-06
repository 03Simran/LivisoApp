// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liviso_flutter/main.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:liviso_flutter/models/profile_data.dart';
import 'package:liviso_flutter/screens/home_scrn.dart';
import 'package:liviso_flutter/screens/login.dart';
import 'package:liviso_flutter/utils/colors.dart';
import 'package:liviso_flutter/widgets/bottom_navigation.dart';

import 'package:http/http.dart' as http;
import 'package:liviso_flutter/widgets/login_widgets.dart';
import 'package:liviso_flutter/widgets/profile_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ProfileScreen extends StatefulWidget {
  final String userId ;
  const ProfileScreen({  required this.userId, Key? key}) : super(key: key);

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
                            builder: (context) => HomeScreen1(id : widget.userId,),
                           ));
    }
    else if(selectedIndex == 2){
     Navigator.of(context).push(
                           MaterialPageRoute(
                            builder: (context) => ProfileScreen(userId : widget.userId,),
                           ));
    }
    else{
      return;
    }
  }


  Future<void> onSave(String editedText, String param) async {

    try {
      String userId; 

      if(widget.userId == ""){
        
        UserIdProvider userIdProvider = context.read<UserIdProvider>();
        userId = userIdProvider.userId;
      }
      else{
        userId = widget.userId;
      }
         final response = await http.post(
                        Uri.parse(
                            'https://stealth-zys3.onrender.com/api/v1/auth/profile/$userId'), 
                        body: {
                          param : editedText,
                        },
                      );

                      if (response.statusCode == 200) {
                        if (kDebugMode) {
                          print("Value CHANGED");
                        }
                        setState(() {
                          profileData = fetchProfileData();
                        });
                      } else {
                        if (kDebugMode) {
                          print("SOME ERROR");
                        }
                      }
                    } catch (error) {
                      if (kDebugMode) {
                        print('eXCEPTION');
                      }
     }
  }

  late Future<ProfileData> profileData; 
  
  Future<ProfileData> fetchProfileData() async {
  try {
     String userId = widget.userId ; 

      if(widget.userId == ""){
        
        UserIdProvider userIdProvider = context.read<UserIdProvider>();
        userId = userIdProvider.userId ;
      }
      else{
        userId = widget.userId;
      }
    final response = await http.get(Uri.parse('https://stealth-zys3.onrender.com/api/v1/auth/getProfile/$userId'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return ProfileData.fromJson(data["user"]);
    } else {
      if (kDebugMode) {
        print('API Request Failed with Status Code: ${response.statusCode}');
      }
      throw Exception('Failed to load profile data : ${response.statusCode}');
    }
  } catch (error) {
    if (kDebugMode) {
      print('Error fetching profile data: $error');
    }
    throw Exception('Failed to load profile data: $error');
  }
}


  @override
  void initState() {
    super.initState();
    if (kDebugMode) {
      print(widget.userId);
    }
    if(widget.userId != ""){
        profileData = fetchProfileData(); 
    }
    
  }

  Future _logout() async{
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove('userId');
    Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),   
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
              return const Center(child: CircularProgressIndicator(
                color: ThemeColors.primaryColor,
              ));
            } else if (snapshot.hasError) {
              // If an error occurs during the API call, display an error message
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData) {
              // If no data is available, you can display an appropriate message
              return const Text('No profile data available.');
            } else {
              // If data is available, display it using your ProfileWidget
              final profile = snapshot.data!;

              return Container(
                color: ThemeColors.backgroundColor,
                padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
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
                    
                          
                          const SizedBox(height: 30),
                          ProfileWidget(label: 'Name',param : 'name' ,initialValue: profile.name,isShopLink: false, id : widget.userId,onSave: onSave,),
                          ProfileWidget(label: 'Phone', param : 'phone', initialValue: profile.phone,isShopLink: false,id : widget.userId,onSave: onSave),
                    
                          ProfileWidget(label: 'Email', param : 'email', initialValue: profile.email,isShopLink: false,id : widget.userId,onSave: onSave),
                          ProfileWidget(label: 'Shop Name', param : 'shopName', initialValue: profile.shopName,isShopLink: false,id : widget.userId,onSave: onSave),
                          ProfileWidget(label: 'Website Link', param : 'webLink',initialValue: profile.webLink,isShopLink: false,id : widget.userId,onSave: onSave),
                          ProfileWidget(label: 'Social Media Link',param : 'socialLink', initialValue: profile.socialLink,isShopLink: false,id : widget.userId,onSave: onSave),

                          ProfileWidget(label: 'Shop Link',param :'shopLink' ,initialValue: profile.shopLink,isShopLink: true,id : widget.userId,onSave: onSave),
                            
                          const SizedBox(height: 30),
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
