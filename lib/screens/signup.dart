import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liviso_flutter/widgets/colors.dart';
import 'package:liviso_flutter/widgets/loginWidgets.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreen();
}

class _SignUpScreen extends State<SignUpScreen> {
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

            TextHd(text: 'Become a partner'),

            SizedBox(height :58.h),

            FormFields(label: 'phoneNumber/Email Id'),

            SizedBox(height: 25.h,),

            FormFields(label: 'Password'),

            SizedBox(height: 25.h,),

            FormFields(label: 'Name'),

            

             SizedBox(height: 96.h,),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Already a partner?',
                style: GoogleFonts.poppins(
                textStyle : TextStyle(
                fontSize: 16.sp,
                color: ThemeColors.primaryColor
               ))),

                TextButton(onPressed: (){}, child: Text('Login',
                style : GoogleFonts.poppins(
                textStyle : TextStyle(
                fontSize: 16.sp,
                color: ThemeColors.primaryColor
               ))
                )),
              ],
            ),

            SizedBox(height: 20.h,),
      
            ButtonMain(enabled: true,label:'Join Waitlist'),

           

          ]),
        )
      )
    );
  }
}