import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:liviso_flutter/screens/homeScrn.dart';

void main() {
  runApp( MyApp(),);
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
        return MaterialApp(
           debugShowCheckedModeBanner: false,
           home: HomeScreen1(),
        );
      }, );
  }
}

