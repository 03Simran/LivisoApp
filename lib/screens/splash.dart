// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:liviso_flutter/screens/homeScrn.dart';
import 'package:liviso_flutter/screens/login.dart';

import 'package:liviso_flutter/widgets/loginWidgets.dart';

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
    print(finalId);
  }
  @override

  void initState() {
    getValidationData().whenComplete(() async {
     Timer(Duration(seconds: 3),(){
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context)=> 
        (finalId == "" || finalId ==null)
        ? LoginScreen()
        :HomeScreen1(id: finalId!)
      ));
    });
    });
    super.initState();

    
  }
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
       
       body: Container(
        color:Colors.blue,
  
        child:Container(
          color: Colors.white,
          child:  Center(child: Logo(fontSize: 100.sp,))
        )
       ), 
    );
  }
}