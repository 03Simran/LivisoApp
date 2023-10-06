// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:liviso_flutter/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:liviso_flutter/screens/home_scrn.dart';
import 'package:liviso_flutter/screens/login.dart';



import 'package:shared_preferences/shared_preferences.dart';


String? finalId ="";

class SplashScreen extends StatefulWidget{
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  Future getValidationData() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? obtainedId = sharedPreferences.getString('userId');
    setState(() {
      finalId = obtainedId;
    });
    if (kDebugMode) {
      print(finalId);
    }
  }
  @override

  void initState() {
    getValidationData().whenComplete(() async {
     Timer(Duration(seconds: 3),(){
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context)=> 
        (finalId == "" || finalId ==null)
        ? LoginScreen()
        : //LoginScreen()
        HomeScreen1(id: finalId!)
      ));
    });
    });
    super.initState();

    
  }
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
       
       body: Container(
        color:ThemeColors.primaryColor,
  
        child:  SafeArea(
          child: Center(
            child: Image.asset(r'assets/images/Liviso White Logo.png',
            width: 700.w,
            height:350.h,
            )
          ),
        )
        
       ), 
    );
  }
}