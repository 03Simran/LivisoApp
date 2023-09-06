import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:liviso_flutter/widgets/colors.dart';
import 'package:liviso_flutter/widgets/homeWidgets.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body : SafeArea(child: Container(
        color: ThemeColors.backgroundColor,
        padding : EdgeInsets.fromLTRB(15.w, 20.h, 15.w, 20.h),
        child : Container(
          height: double.infinity,
          width:double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.r)
          ),
          

          child : Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height : 40.h),
              CircleAvatar(radius: 55.r,backgroundColor: Colors.blue,),
              SizedBox(height: 30.h,),
              ProfileWidget(label: 'label', initialValue: 'Value',),

              
              ProfileWidget(label: 'label', initialValue: 'Value',),
              
              ProfileWidget(label: 'label', initialValue: 'Value',),

              ProfileWidget(label: 'label', initialValue: 'Value',),

              ProfileWidget(label: 'label', initialValue: 'Value',),



          ],)
        )
      ))
    );
  }
}