import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:liviso_flutter/main.dart';
import 'package:liviso_flutter/screens/home_scrn.dart';
import 'package:liviso_flutter/utils/colors.dart';
import 'package:liviso_flutter/widgets/login_widgets.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class MissedCallNotification extends StatelessWidget {
  final String phone;
  final String roomName;
  const MissedCallNotification({required this.phone,required this.roomName, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body : SafeArea(
        child: Container(
          color: Colors.white,
          padding : EdgeInsets.symmetric(vertical: 215.h, horizontal: 70.w),
          child : Center(
            child: Column(
              children: [
                Container(
                  height: 200.h,
                  width: 400.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: ThemeColors.backgroundColor,
                  ),
                  padding :  EdgeInsets.all(30.h),
                  child : Center(
                    child : Column(
                      children: [
                       const TextHd(text: 'Missed Call'),
                        SizedBox(height: 20.h,),
                        TextHd(text: phone)

                      ],
                    )
                  )
                ),

                SizedBox(height: 20.h,),
                Center(child: TextButton(onPressed: ()async {
                   UserIdProvider userIdProvider = context.read<UserIdProvider>();
     String userId = userIdProvider.userId ;

     final responsed = await  http.get(Uri.parse(
       'https://stealth-zys3.onrender.com/api/v1/video/getCalls?roomName=$roomName&id=$userId')); 
       print("Calls added")  ;

      

      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => HomeScreen1(
          id: userId,
        ),
      ));
                }, 
                child: Text( "Go to Home Screen", style: TextStyle(
                  color: ThemeColors.primaryColor,
                  fontSize: 20.sp
                ),)),)
              ],
            ),


          )
        ) )
    );
  }
}