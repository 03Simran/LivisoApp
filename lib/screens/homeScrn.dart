// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liviso_flutter/widgets/colors.dart';
import 'package:liviso_flutter/widgets/homeWidgets.dart';
import 'package:liviso_flutter/widgets/loginWidgets.dart';

class HomeScreen1 extends StatefulWidget {
  const HomeScreen1({super.key});

  @override
  State<HomeScreen1> createState() => _HomeScreen1State();
}

class _HomeScreen1State extends State<HomeScreen1> {
  bool incomingCall = true;
  bool livecalling = true;
  final incomingCallNo = '8252645278';
  late final callsData;

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/data.json');
    callsData = json.decode(response);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Logo(fontSize: 25.sp),
        titleSpacing: 15.w,
        elevation: 3,
        actions: <Widget>[
          Row(
            children: [
              Text(
                'Live Calling',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black, // Add desired text color
                  ),
                ),
              ),
              SizedBox(width: 6.w), // Add spacing between text and icon
              livecalling
                  ? Icon(
                      Icons.toggle_on,
                      size: 40.h,
                      color: ThemeColors.primaryColor,
                    )
                  : Icon(Icons.toggle_off,
                      color: ThemeColors.textColor7, size: 40.h),
              SizedBox(
                width: 10.w,
              )
            ],
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(13.w),
        color: ThemeColors.backgroundColor,
        child: Stack(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Recent Calls',
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: ThemeColors.textColor6))),
              SizedBox(height: 17.h),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(children: [
                    CallElement(),CallElement(),CallElement(),CallElement(),CallElement(),CallElement(),CallElement(),CallElement(),CallElement(),
                    CallElement()
                  ],)
                ),
              ),
            ],
          ),
          incomingCall && livecalling
              ? Visibility(
                  visible: true,
                  child: Positioned(
                      top: 70.h,
                      left: 30.w,
                      child: Container(
                          height: 346.h,
                          width: 269.w,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey
                                      .withOpacity(0.5), // Shadow color
                                  spreadRadius: 2, // Spread radius
                                  blurRadius: 5, // Blur radius
                                  offset: Offset(
                                      0, 3), // Offset in x and y direction
                                ),
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.r)),
                          child: Column(
                            children: [
                              SizedBox(height: 45.h),
                              Text('Incoming Call from',
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.normal))),
                              SizedBox(height: 20.h),
                              Text(incomingCallNo,
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          fontSize: 25.sp,
                                          fontWeight: FontWeight.w800))),
                              Spacer(),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      
                                    },
                                    child: CircleAvatar(
                                      backgroundColor: Colors.green,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 70.w,
                                  ),
                                  CircleAvatar(
                                    backgroundColor: Colors.red,
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 45.h,
                              )
                            ],
                          ))),
                )
              : Visibility(visible: false, child: Container())
        ]),
      ),
      bottomNavigationBar: BottomNavigationBar(items: const [
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
      ]),
    );
  }
}