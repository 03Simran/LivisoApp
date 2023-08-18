import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liviso_flutter/widgets/colors.dart';

class VideoCallScreen extends StatefulWidget {
  var incomingCallNo;

  VideoCallScreen(
      {required this.incomingCallNo,
      Key? key})
      : super(key: key);

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  late double height, width;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text('Live Call',
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF1F2937)))),
          elevation: 3,
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
        body: Container(
            padding: EdgeInsets.all(13.w),
            color: ThemeColors.backgroundColor,
            child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10.r)),
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 290.h,
                          width: 330.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadiusDirectional.only(
                              topStart: Radius.circular(10.r),
                              topEnd: Radius.circular(10.r),
                            ),
                            color: Colors.red,
                          ),
                        ),
                        Container(
                          height: 290.h,
                          width: 330.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadiusDirectional.only(
                                bottomStart: Radius.circular(10.r),
                                bottomEnd: Radius.circular(10.r)),
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                        child: Padding(
                      padding: EdgeInsets.all(15.w),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(8.w),
                            decoration: BoxDecoration(
                                color: ThemeColors.backgroundColor,
                                borderRadius: BorderRadius.circular(10.r)),
                            child: Text(widget.incomingCallNo,
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        color: ThemeColors.textColor9,
                                        fontSize: 17.sp,
                                        fontWeight: FontWeight.w700))),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.all(8.w),
                            decoration: BoxDecoration(
                                color: ThemeColors.backgroundColor,
                                borderRadius: BorderRadius.circular(10.r)),
                            child: Text('30:39',
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        color: ThemeColors.textColor9,
                                        fontSize: 17.sp,
                                        fontWeight: FontWeight.w700))),
                          ),
                        ],
                      ),
                    )),
                    Positioned(
                        top: 240.h,
                        left: 300.w,
                        child: Container(
                          height: 20.h,
                          width: 20.w,
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.arrow_back),
                            iconSize: 20.w,
                            color: Colors.white,
                          ),
                        )),
                    Positioned(
                        top: 530.h,
                        left: 300.w,
                        child: Container(
                          height: 20.h,
                          width: 20.w,
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.arrow_back),
                            iconSize: 20.w,
                            color: Colors.white,
                          ),
                        )),
                    Positioned(
                      top: 310.h,
                      left: 15.w,
                      child: Container(
                        padding: EdgeInsets.all(8.w),
                        decoration: BoxDecoration(
                            color: ThemeColors.backgroundColor,
                            borderRadius: BorderRadius.circular(10.r)),
                        child: Text('You',
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: ThemeColors.textColor9,
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.w700))),
                      ),
                    ),
                    Positioned(
                        top: 550.h,
                        left: 231.w,
                        child: Container(
                          height: 40.w,
                          width: 40.w,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.w)),
                         
                        )),
                    Positioned(
                        top: 550.h,
                        left: 82.w,
                        child: Container(
                          height: 40.w,
                          width: 40.w,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.w)),
                        )),
                    Positioned(
                        top: 550.h,
                        left: 153.w,
                        child: Container(
                          height: 40.w,
                          width: 40.w,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.w)),
                        )),
                  ],
                ))));
  }
}
