// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liviso_flutter/screens/homeScrn.dart';
import 'package:http/http.dart' as http;
import 'package:liviso_flutter/screens/addprofile.dart';
import 'package:liviso_flutter/screens/signup.dart';
import 'package:liviso_flutter/utils/colors.dart';
import 'package:liviso_flutter/widgets/loginWidgets.dart';

class LoginScreen extends StatefulWidget {
  static final GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {

  late final String user_id;
  TextEditingController phoneTextController = TextEditingController() ;
  TextEditingController passwordTextController = TextEditingController();



  @override
  void initState() {
    super.initState();
   
  }

  final RegExp phoneRegex =  RegExp(r'^[0-9]{10}$');
  final RegExp passwordRegex =
      RegExp(r'^(?=.*[a-zA-Z0-9!@#$%^&*()-_=+{}\[\]|;:",.<>?]).{4,}$');

  String? validateEmail(String? value) {
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

   Future<void> _login() async {
    if (LoginScreen.loginKey.currentState!.validate()) {
     
      final String phone = phoneTextController.text;
      final String password = passwordTextController.text;

      if (phone.isEmpty || password.isEmpty) {
  // Handle the case where either phone or password is empty.
  print('Phone or password is empty.');
  return; // Don't proceed with the API call.
}

      final Map<String, dynamic> data = {
         
    "phone":phone,
    "password":password

      };

      

      final String jsonData = jsonEncode(data);

      try {
        final response = await http.post(
          Uri.parse('https://stealth-zys3.onrender.com/api/v1/auth/login'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonData,
        );

        if (response.statusCode == 200) {
          final Map<String, dynamic> responseBody = json.decode(response.body);
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
         const SnackBar(content: Text('Logged in Successfully')),
         );
          

          user_id= responseBody['userId'];
          print(response.body);
         

           Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => HomeScreen1(id : user_id,),
            ),
          );
          
        } else {

          print('Failed to send profile data. Status code: ${response.body}');
        }
      } catch (e) {
  
        print('Error sending profile data: $e');
      }
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
              key : LoginScreen.loginKey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 110.h,
                    ),
                    Logo(
                      fontSize: 44.sp,
                    ),
                    SizedBox(
                      height: 45.h,
                    ),
                    const TextHd(text: 'Login'),
                    SizedBox(height: 48.h),
                    FormFields(
                      label: 'Phone',
                      hint: '99999999999',
                      enabled: true,
                      controller: phoneTextController,
                      validateFunction: validateEmail,
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    FormFields(
                      label: 'Password',
                      hint: '#@1234',
                      enabled: true,
                      controller: passwordTextController,
                      validateFunction: validatePassword,
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextButton(
                            onPressed: () {
                              
                            },
                            child: Text('Forgot Password?',
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        fontSize: 16.sp,
                                        color: ThemeColors.primaryColor)))),
                      ],
                    ),
                    SizedBox(
                      height: 96.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Don\'t have an accout?',
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    fontSize: 16.sp,
                                    color: ThemeColors.primaryColor))),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => SignUpScreen(),
            ),
          );
                            },
                            child: Text('SignUp',
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        fontSize: 16.sp,
                                        color: ThemeColors.primaryColor)))),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    ButtonMain(
                      enabled: true,
                      label: 'Proceed',
                      onPressed: _login
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('By clicking, I accept the ',
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                              fontSize: 10.sp,
                            ))),
                        const ExternalLink(
                            text: 'Priavcy Policy',
                            link: 'https://www.google.com/'),
                        Text(' and ',
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                              fontSize: 10.sp,
                            ))),
                        const ExternalLink(
                            text: 'Terms and Conditions',
                            link: 'https://www.google.com/')
                      ],
                    ),
                    SizedBox(height: 50.h)
                  ]),
            ),
          ),
        )));
  }
}
