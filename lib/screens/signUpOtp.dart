import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liviso_flutter/screens/login.dart';
import 'package:liviso_flutter/widgets/colors.dart';
import 'package:liviso_flutter/widgets/loginWidgets.dart';
import 'package:liviso_flutter/widgets/timer.dart';


class SignUpOtp extends StatefulWidget {

    var phonefromScreen ;
    SignUpOtp(
      {required this.phonefromScreen,
      Key? key})
      : super(key: key);

  @override
  State<SignUpOtp> createState() => _SignUpOtpState();
}

class _SignUpOtpState extends State<SignUpOtp> {
  final Otpkey = GlobalKey<FormState>();
  
   late TextEditingController phoneText ;
   TextEditingController otpText = TextEditingController();
   
  @override
  void initState() {
    super.initState();
    phoneText = TextEditingController(text: widget.phonefromScreen);
  }

  final RegExp otpRegex = RegExp(r'^\d{6}$');
  final RegExp phoneRegex = RegExp(r'^\+?91?[6789]\d{9}$');

   String? validatePhoneNumber(String? value) {
    if (value!.isEmpty || !phoneRegex.hasMatch(value)) {
      
      return "Enter valid phone number";
    } else {
      
      return null;
    }
  }
  
  String? validateOtp(String? value) {
    if (value!.isEmpty || !otpRegex.hasMatch(value)) {
      
      return "Enter valid otp";
    } else {
      
      return null;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:SafeArea(
        child:  Container(
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
                          
                    TextHd(text: 'OTP Verification'),
                          
                    SizedBox(height :58.h),
                          
                    FormFields(
                      label: 'Phone Number',
                      hint : '9999999999',
                      enabled:true,
                      controller: phoneText,
                      validateFunction: validatePhoneNumber,
              
                      ),
                          
                    SizedBox(height: 25.h,),
                        FormFields(
                      label: 'OTP',
                      hint : '123456',
                      enabled:true,
                      controller: otpText,
                      validateFunction: validateOtp,
                      ),  
                    
                          
                    SizedBox(height: 25.h,),
                          
                    
                          
                    
                          
                     
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          
                        TextButton( 
                          onPressed: (){}, child: Text('Resend OTP',
                        style : GoogleFonts.poppins(
                        textStyle : TextStyle(
                        fontSize: 16.sp,
                        color: ThemeColors.primaryColor
                       ))
                        )),
                
                        CountdownTimer(),
                      ],
                    ),
                
                    SizedBox(height: 96.h,),
                          
                    SizedBox(height: 20.h,),
                      
                    ButtonMain(
                      enabled: true,
                      label:'Join Waitlist',
                      onPressed: (){
                        if(phoneText.text.toString()!.isEmpty || !RegExp(r'^\+?91?[6789]\d{9}$').hasMatch(phoneText.text.toString()))
                         { 
                          
                          print('Failure');
                          
                          }
                         else{
                          print(phoneText.text.toString());
                          print('Success');
                
                          Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => LoginScreen(phonefromotp:phoneText.text.toString() )));
                         }
                    },),

                    SizedBox(height: 50.h,)
                          
                   
                          
                  ]),
                ),
              
            
          ),
        
      )
    );
  }
}