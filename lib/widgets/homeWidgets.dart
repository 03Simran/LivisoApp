import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';


class CallElement extends StatefulWidget {
  const CallElement({super.key});

  @override
  State<CallElement> createState() => _CallElementState();
}

class _CallElementState extends State<CallElement> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.all(5.h),
      height:50.h,
      width: double.infinity,
      padding: EdgeInsets.all(2.w),
      decoration:BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r)
        ),
        
        child: Row(

          children: [

          SizedBox(width:7.w),
          
          Icon(Icons.arrow_circle_left,size: 20.w,),

          SizedBox(width: 7.w),

          Text('66666666660',
          style : GoogleFonts.poppins(
            textStyle : TextStyle (
              fontSize: 17.sp,
              fontWeight: FontWeight.w500,
              color: Colors.red
            )
          )),
           
           Spacer(),
          
          Column( 
            crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('durn',
          style : GoogleFonts.poppins(
            textStyle : TextStyle (
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: ThemeColors.textColor5
            )
          )),
            Text('durnbhr nf4infomni',
          style : GoogleFonts.poppins(
            textStyle : TextStyle (
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: ThemeColors.textColor5
            )
          )),
          ],),

          SizedBox(width: 7.w)
        ],)
    );
  }
}