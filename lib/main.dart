import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:liviso_flutter/screens/homeScrn.dart';
import 'package:liviso_flutter/screens/resetPassword.dart';
import 'package:liviso_flutter/screens/signup.dart';
import 'package:liviso_flutter/screens/vCallScreen.dart';

import 'screens/login.dart';

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

