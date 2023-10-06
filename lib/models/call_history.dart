
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/colors.dart';

class CallHistoryData {
 
  final String roomName;
  final int cusNumber;
  final String date;
  final bool isRejected;
  final bool isAccepted;
  final String phone;
  final String duration ;
  final String feedback;
  final String emoji;
  final String userId;


  CallHistoryData({
    required this.userId,
   
    required this.roomName,
    required this.cusNumber,
    required this.date,
    required this.isRejected,
    required this.isAccepted,
    required this.phone,
    required this.feedback,
    required this.emoji,
    required this.duration
 
  });

  factory CallHistoryData.fromJson(Map<String, dynamic> json) {
    return CallHistoryData(
      roomName: json['roomName'],
      cusNumber: json['cusNumber'],
      date: json['date'],
      isRejected: json['isRejected'],
      isAccepted: json['isAccepted'],
      phone : json['phone'],
      userId: json['userId'],
      feedback: json['feedback'],
      emoji: json['emoji'],
      duration : json['duration']
     
    );
  }
}





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
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
              color: Colors.red
            )
          )),
           
          const Spacer(),
          
          Column( 
            crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('durn',
          style : GoogleFonts.poppins(
            textStyle : TextStyle (
              fontSize: 9.sp,
              fontWeight: FontWeight.w500,
              color: ThemeColors.textColor5
            )
          )),
            Text('durnbhr nf4infomni',
          style : GoogleFonts.poppins(
            textStyle : TextStyle (
              fontSize: 9.sp,
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

