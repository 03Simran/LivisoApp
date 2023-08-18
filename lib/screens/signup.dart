import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liviso_flutter/screens/signUpOtp.dart';
import 'package:liviso_flutter/widgets/colors.dart';
import 'package:liviso_flutter/widgets/loginWidgets.dart';



class SignUpScreen extends StatefulWidget {
  static final GlobalKey<FormState> phonekey = GlobalKey<FormState>();

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController phoneTextController = TextEditingController();
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController nameTextController = TextEditingController();

  final RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
  final RegExp phoneRegex = RegExp(r'^\+?91?[6789]\d{9}$');
  final RegExp nameRegex = RegExp(r'^[a-zA-Z- ]+$');

   double gap = 25.h;

   String? validatePhoneNumber(String? value) {
    if (value!.isEmpty || !phoneRegex.hasMatch(value)) {
      
      return "Enter valid phone number";
    } else {
      
      return null;
    }
  }

  String? validateEmail(String? value) {
    if (value!.isEmpty || !emailRegex.hasMatch(value)) {
      
      return "Enter valid email";
    } else {
      
      return null;
    }
  }
  String? validateName(String? value) {
    if (value!.isEmpty || !nameRegex.hasMatch(value)) {
      
      return "Enter valid name";
    } else {
      
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
            height: double.infinity,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 23.w, vertical: 0),
            child: SingleChildScrollView(
              child: Form(
                key: SignUpScreen.phonekey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 129.h,),
                    Logo(fontSize: 44.sp,),
                    SizedBox(height: 52.h,),
                    TextHd(text: 'Become a partner'),
                    SizedBox(height: 58.h),
                    FormFields(
                      label: 'Phone Number',
                      hint: '9999999999',
                      enabled: true,
                      controller: phoneTextController,
                      validateFunction: validatePhoneNumber,
                    ),
                    SizedBox(height: gap,),
                    FormFields(
                      label: 'Email',
                      hint: 'someone@gmail.com',
                      enabled: true,
                      controller: emailTextController, 
                      validateFunction: validateEmail,// Create a new controller if needed
                    ),
                    SizedBox(height: gap),
                    FormFields(
                      label: 'Name',
                      hint: 'Your Name',
                      enabled: true,
                      controller: nameTextController, 
                      validateFunction: validateName,// Create a new controller if needed
                    ),
                    SizedBox(height: 35.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Already a partner?',
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    fontSize: 16.sp,
                                    color: ThemeColors.primaryColor))),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'Login',
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    fontSize: 16.sp,
                                    color: ThemeColors.primaryColor)),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h,),
                    ButtonMain(
                      enabled: true,
                      label: 'Join Waitlist',
                      onPressed: () {
                        if (SignUpScreen.phonekey.currentState!.validate()) {
                          // Form validation successful, proceed with submission
                           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignUpOtp(phonefromScreen:phoneTextController.text.toString()  )));
                          }
                          else{
                            print('Error validating the key');
                          }
                        
                      },
                    ),

                    SizedBox(height: 50.h,)
                  ],
                ),
                
              ),
            ),
          ),
        
      ),
    );
  }
  
}
