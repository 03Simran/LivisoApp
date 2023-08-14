import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liviso_flutter/widgets/colors.dart';
import 'package:liviso_flutter/widgets/loginWidgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:SafeArea(
        child: Container(
          height :double.infinity,
          width:double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 23.w,vertical:0),
          child: Column(
            mainAxisAlignment:MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children : [

            SizedBox(height: 129.h,),

            Logo(fontSize: 44.sp,),

            SizedBox(height: 52.h,),

            TextHd(text: 'Login'),

            SizedBox(height :58.h),

            FormFields(label: 'phoneNumber/Email Id'),

            SizedBox(height: 25.h,),

            FormFields(label: 'Password'),

            SizedBox(height: 15.h,),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton(onPressed: (){}, child: Text('Forgot Password?',
                style: GoogleFonts.poppins(
                textStyle : TextStyle(
                fontSize: 16.sp,
                color: ThemeColors.primaryColor
               ))
                )),
              ],
            ),

             SizedBox(height: 96.h,),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Don\'t have an accout?',
                style: GoogleFonts.poppins(
                textStyle : TextStyle(
                fontSize: 16.sp,
                color: ThemeColors.primaryColor
               ))),

                TextButton(onPressed: (){}, child: Text('SignUp',
                style : GoogleFonts.poppins(
                textStyle : TextStyle(
                fontSize: 16.sp,
                color: ThemeColors.primaryColor
               ))
                )),
              ],
            ),

            SizedBox(height: 20.h,),

            ButtonMain(enabled: true,label : 'Proceed'),

            SizedBox(height: 5.h,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('By clicking, I accept the ',
                style: GoogleFonts.poppins(
                textStyle : TextStyle(
                fontSize: 13.sp,
               ))),

                const ExternalLink(text: 'Priavcy Policy', link: 'https://www.google.com/'),
                
   
                Text(' and ',
                style: GoogleFonts.poppins(
                textStyle : TextStyle(
                fontSize: 13.sp,
               ))),
                
                const ExternalLink(text: 'Terms and Conditions', link: 'https://www.google.com/')


              ],
            ),







            






          ]),
        )
      )
    );
  }
}