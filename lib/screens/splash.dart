// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:liviso_flutter/screens/signup.dart';
import 'package:liviso_flutter/widgets/loginWidgets.dart';


class SplashScreen extends StatefulWidget{
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override

  void initState() {
    super.initState();

    Timer(Duration(seconds: 3),(){
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context)=> SignUpScreen()
      ));
    });
  }
  Widget build(BuildContext context){
    return Scaffold(
       body: Container(
        color:Colors.blue,
        
        // ignore: prefer_const_constructors
        child:Container(
          color: Colors.white,
          child:  Center(child: Logo(fontSize: 100.sp,))
        )
       ), 
    );
  }
}