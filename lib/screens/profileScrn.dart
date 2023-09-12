import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:liviso_flutter/models/profile_data.dart';
import 'package:liviso_flutter/screens/homeScrn.dart';
import 'package:liviso_flutter/utils/colors.dart';
import 'package:liviso_flutter/widgets/bottom_navigation.dart';
import 'package:liviso_flutter/widgets/homeWidgets.dart';
import 'package:http/http.dart' as http;


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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<ProfileData>(
          future: profileData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // While waiting for the API response, show a loading indicator
              return CircularProgressIndicator();
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      
                      SizedBox(height: 30),
                      ProfileWidget(label: 'Name', initialValue: profile.name),
                      ProfileWidget(label: 'Email', initialValue: profile.email),
                      ProfileWidget(label: 'Shop Name', initialValue: profile.shopName),
                      ProfileWidget(label: 'Website Link', initialValue: profile.webLink),
                      ProfileWidget(label: 'Social Media Link', initialValue: profile.socialLink),
                      ProfileWidget(label: 'Shop Link', initialValue: profile.shopLink),
                      ProfileWidget(label: 'Phone', initialValue: profile.phone),

                      Text(profile.shopLink, style : TextStyle(fontSize: 10))
                      
                      
                    ],
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
