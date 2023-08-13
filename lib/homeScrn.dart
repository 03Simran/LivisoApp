// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liviso_flutter/assets/colors.dart';
import 'package:liviso_flutter/assets/homeWidgets.dart';
import 'package:liviso_flutter/assets/loginWidgets.dart';

class HomeScreen1 extends StatefulWidget {
  const HomeScreen1({super.key});

  @override
  State<HomeScreen1> createState() => _HomeScreen1State();
}

class _HomeScreen1State extends State<HomeScreen1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Logo(fontSize: 25.sp),
          elevation: 3,
        ),
        body: Container(
          padding: EdgeInsets.all(13.w),
          color: ThemeColors.backgroundColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Recent Calls',
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: ThemeColors.textColor6))),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 17.h),
                      CallElement(),
                      CallElement(),
                      CallElement(),
                      CallElement(),
                      CallElement(),
                      CallElement(),
                      CallElement(),
                      CallElement(),
                      CallElement(),
                      CallElement(),
                      CallElement(),
                      CallElement(),
                      CallElement(),
                    ],
                  ),
                ),
              ),

            
            ],
          ),

        ),
        bottomNavigationBar: BottomNavigationBar(items:const [
           BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
        ]),);
  }
}
