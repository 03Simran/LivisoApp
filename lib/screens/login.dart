import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liviso_flutter/screens/homeScrn.dart';
import 'package:liviso_flutter/screens/resetPassword.dart';
import 'package:liviso_flutter/widgets/colors.dart';
import 'package:liviso_flutter/widgets/loginWidgets.dart';

class LoginScreen extends StatefulWidget {
  var phonefromotp ;
    LoginScreen(
      {required this.phonefromotp,
      Key? key})
      : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  late TextEditingController phoneTextController ;
   var passwordTextController = TextEditingController();

   @override
  void initState() {
    super.initState();
    phoneTextController= TextEditingController(text: widget.phonefromotp);
  }
   
   final RegExp phoneRegex = RegExp(r'^\+?91?[6789]\d{9}$');
   final RegExp passwordRegex = RegExp(r'^(?=.*[a-zA-Z0-9!@#$%^&*()-_=+{}\[\]|;:",.<>?]).{4,}$');

   String? validatePhoneNumber(String? value) {
    if (value!.isEmpty || !phoneRegex.hasMatch(value)) {
      
      return "Enter valid phone number";
    } else {
      
      return null;
    }
  }
  
  String? validatePassword(String? value) {
    if (value!.isEmpty || !passwordRegex.hasMatch(value)) {
      
      return "Not a valid password";
    } else {
      
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:SafeArea(
        child: Container(
          height :double.infinity,
          width:double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 23.w,vertical:0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment:MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children : [
          
              SizedBox(height: 110.h,),
          
              Logo(fontSize: 44.sp,),
          
              SizedBox(height: 45.h,),
          
              TextHd(text: 'Login'),
          
              SizedBox(height :48.h),
          
              FormFields(label: 'PhoneNumber',hint :'hbudfub',enabled : true,controller: phoneTextController,validateFunction: validatePhoneNumber, ),
          
              SizedBox(height: 25.h,),
          
              FormFields(label: 'Password',hint :'hfbr vrj',enabled : true,controller: passwordTextController,validateFunction: validatePassword,),
          
              SizedBox(height: 15.h,),
          
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton(onPressed: (){
                  // Navigator.push(context,MaterialPageRoute(builder: (context) => const ResetPassword())); 
                  }, child: Text('Forgot Password?',
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
          
              SizedBox(height: 10.h,),
          
              ButtonMain(enabled: true,label : 'Proceed',onPressed: (){
                Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => const HomeScreen1()));
              },),
          
              SizedBox(height: 5.h,),
          
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('By clicking, I accept the ',
                  style: GoogleFonts.poppins(
                  textStyle : TextStyle(
                  fontSize: 10.sp,
                 ))),
          
                  const ExternalLink(text: 'Priavcy Policy', link: 'https://www.google.com/'),
                  
             
                  Text(' and ',
                  style: GoogleFonts.poppins(
                  textStyle : TextStyle(
                  fontSize: 10.sp,
                 ))),
                  
                  const ExternalLink(text: 'Terms and Conditions', link: 'https://www.google.com/')
          
          
                ],
              ),
          
              SizedBox(height: 50.h)
          
          
          
          
          
          
          
              
          
          
          
          
          
          
            ]),
          ),
        )
      )
    );
  }
}