import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:liviso_flutter/homeScrn.dart';
import 'package:liviso_flutter/resetPassword.dart';
import 'package:liviso_flutter/signup.dart';
import 'package:liviso_flutter/vCallScreen.dart';

import 'login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize:const Size(360,800),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return const MaterialApp(
           debugShowCheckedModeBanner: false,
           home: VideoCallScreen(),
        );
      }, );
  }
}

