
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/colors.dart';

class CallData {
  final String phoneNo;
  final bool accepted;
  final int duration;
  final String dateTime;

  CallData({
    required this.phoneNo,
    required this.accepted,
    required this.duration,
    required this.dateTime,
  });
}

class JsonDataDisplay extends StatefulWidget {
  @override
  _JsonDataDisplayState createState() => _JsonDataDisplayState();
}

class _JsonDataDisplayState extends State<JsonDataDisplay> {
  List<CallData> callDataList = [];

  Future<void> loadJsonData() async {
    final String response = await rootBundle.loadString('assets/calls.json');
    final List<CallData> parsedData = parseJson(response);
    setState(() {
      callDataList = parsedData;
    });
  }

  List<CallData> parseJson(String response) {
    final List<dynamic> jsonData = json.decode(response);
    return jsonData.map((data) {
      return CallData(
        phoneNo: data['phoneNo'],
        accepted: data['accepted'],
        duration: data['duration'],
        dateTime: data['date&time'],
      );
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    loadJsonData();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: callDataList.length,
        itemBuilder: (BuildContext context, int index) {
          final call = callDataList[index];
          return Container(
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
          
          call.accepted ? Icon(Icons.check,size:20.w) : Icon(Icons.close,size:20.w),

          SizedBox(width: 7.w),

          Text(call.phoneNo,
          style : GoogleFonts.poppins(
            textStyle : TextStyle (
              fontSize: 17.sp,
              fontWeight: FontWeight.w500,
              color: call.accepted? ThemeColors.textColor9 : Colors.red
            )
          )),
           
           Spacer(),
          
          Column( 
            crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            call.accepted? Text(call.duration.toString() + 's',
          style : GoogleFonts.poppins(
            textStyle : TextStyle (
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              color: ThemeColors.textColor5
            )
          )) : Text(''),
            Text(call.dateTime,
          style : GoogleFonts.poppins(
            textStyle : TextStyle (
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              color: ThemeColors.textColor5
            )
          )),
          ],),

          SizedBox(width: 7.w)
        ],)
    ); 
   } ); }
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
           
           Spacer(),
          
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

