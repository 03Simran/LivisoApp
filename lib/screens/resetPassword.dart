import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:liviso_flutter/widgets/colors.dart';
import 'package:liviso_flutter/widgets/loginWidgets.dart';

class ResetPassword extends StatefulWidget {
  final phonefromOtp ;
   const ResetPassword(
      {required this.phonefromOtp,
      Key? key})
      : super(key: key);


  @override
  State<ResetPassword
  > createState() => _ResetPassword();
}

class _ResetPassword extends State<ResetPassword> {
  var pw = TextEditingController();
  @override
  void initState() {
    super.initState();
    pw = TextEditingController(text: widget.phonefromOtp);
  }

   String? validatePhoneNumber(String? value) {
    if (value!.isEmpty || !RegExp(r'^\+?91?[6789]\d{9}$').hasMatch(value)) {
      
      return "Enter correct phone number";
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
          
              SizedBox(height: 129.h,),
          
              Logo(fontSize: 44.sp,),
          
              SizedBox(height: 52.h,),
          
              const TextHd(text: 'Reset Password'),
          
              SizedBox(height :58.h),
          
              FormFields(label: 'phoneNumber',hint :'fhbrugurb',enabled : true,controller: pw,validateFunction: validatePhoneNumber,),
          
              SizedBox(height: 200.h,),
              
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
          
              ButtonMain(enabled: true,label : 'Reset Password',onPressed: (){
                //Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpOtp()));
              },),
          
              SizedBox(height: 5.h,),
          
            
            ]),
          ),
        )
      )
    );
  }
}