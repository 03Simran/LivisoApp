// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:liviso_flutter/screens/login.dart';

import 'package:liviso_flutter/utils/colors.dart';
import 'package:liviso_flutter/widgets/login_widgets.dart';


class ForgotPasswordScrn extends StatefulWidget {
  
  

  const ForgotPasswordScrn({ Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScrn> createState() => _ForgotPasswordScrn();
}

class _ForgotPasswordScrn extends State<ForgotPasswordScrn> {
  final GlobalKey<FormState> fgtPswdKey = GlobalKey<FormState>();
  
  bool isLoading = false;
  TextEditingController phoneTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  

  @override
  void initState() {
    super.initState();
  }

  final RegExp phoneRegex = RegExp(r'^[0-9]{10}$');
  final RegExp passwordRegex =
      RegExp(r'^(?=.*[a-zA-Z0-9!@#$%^&*()-_=+{}\[\]|;:",.<>?]).{4,}$');

  String? validatePhone(String? value) {
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


  Future<void> _sendPassword() async {
    if (fgtPswdKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      final String phone = phoneTextController.text;
      final String password = passwordTextController.text;

      if (phone.isEmpty || password.isEmpty) {
        // Handle the case where either phone or password is empty.
        if (kDebugMode) {
          print('Phone or password is empty.');
        }
        return; // Don't proceed with the API call.
      }

      final Map<String, dynamic> data = {
        "phone": phone,
        "password": password,

      };

      final String jsonData = jsonEncode(data);

      try {
        
        final response = await http.post(
          Uri.parse('https://stealth-zys3.onrender.com/api/v1/auth/forget-password'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonData,
        );

        if (response.statusCode == 200) {
          
          setState(() {
            isLoading = false;
          });
          
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Password Reset")),
          );
          if (kDebugMode) {
            print(response.body);
          }

          Navigator.of(context).pushReplacement(
                           MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                           ));
          
        } else if (response.statusCode == 400) {
          final Map<String, dynamic> responseBody = json.decode(response.body);
          setState(() {
            isLoading = false;
          });
          // print('Failed to send profile data. Status code: ${response.body}');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(responseBody['message'])),
          );
        } else {
          setState(() {
            isLoading = false;
          });
          // print('Failed to send profile data. Status code: ${response.body}');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('An error occured.Try again')),
          );
        }
      } catch (e) {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('An error occured.Try again')),
        );
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
              key: fgtPswdKey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 110.h,
                    ),
                    Logo(height: 100.h,width: 200.w,),
                    SizedBox(
                      height: 45.h,
                    ),
                    const TextHd(text: 'Reset Password'),
                    SizedBox(height: 48.h),
                    FormFields(
                      label: 'Phone',
                      hint: '99999999999',
                      enabled: true,
                      controller: phoneTextController,
                      validateFunction: validatePhone,
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
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.end,
                    //   //crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //      TextButton(
                    //         onPressed: () {},
                    //         child: Text('Forgot Password?',
                    //              style: GoogleFonts.poppins(
                    //                 textStyle: TextStyle(
                    //                     fontSize: 16.sp,
                    //                    color: ThemeColors.primaryColor)))),
                    //   ],
                    // ),
                    SizedBox(
                      height: 96.h,
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   //crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     Text('Don\'t have an accout?',
                    //         style: GoogleFonts.poppins(
                    //             textStyle: TextStyle(
                    //                 fontSize: 16.sp,
                    //                 color: ThemeColors.primaryColor))),
                    //     TextButton(
                    //         onPressed: () {
                    //           Navigator.of(context).pushReplacement(
                    //             MaterialPageRoute(
                    //               builder: (context) => const SignUpScreen(),
                    //             ),
                    //           );
                    //         },
                    //         child: Text('SignUp',
                    //             style: GoogleFonts.poppins(
                    //                 textStyle: TextStyle(
                    //                     fontSize: 16.sp,
                    //                     color: ThemeColors.primaryColor)))),
                    //   ],
                    // ),
                    SizedBox(
                      height: 10.h,
                    ),
                    !isLoading
                        ? ButtonMain(
                            enabled: true, label: 'Reset Password', onPressed: _sendPassword)
                        : SizedBox(
                            width: 310.w,
                            height: 50.h,
                            child: FloatingActionButton(
                                onPressed: null,
                                backgroundColor: ThemeColors.primaryColor,
                                foregroundColor: Colors.white,
                                shape: ContinuousRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.r)),
                                child: const Center(
                                    child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                ))),
                          ),
                    SizedBox(
                      height: 5.h,
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   mainAxisSize: MainAxisSize.min,
                    //   //crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     Text('By clicking, I accept the ',
                    //         style: GoogleFonts.poppins(
                    //             textStyle: TextStyle(
                    //           fontSize: 10.sp,
                    //         ))),
                    //     const ExternalLink(
                    //         text: 'Priavcy Policy',
                    //         link: 'https://www.google.com/'),
                    //     Text(' and ',
                    //         style: GoogleFonts.poppins(
                    //             textStyle: TextStyle(
                    //           fontSize: 10.sp,
                    //         ))),
                    //     const ExternalLink(
                    //         text: 'Terms and Conditions',
                    //         link: 'https://www.google.com/')
                    //   ],
                    // ),
                    SizedBox(height: 50.h)
                  ]),
            ),
          ),
        )));
  }
  @override
  void dispose() {
    // Dispose of resources here
    fgtPswdKey.currentState?.dispose(); // Dispose of FormState
    phoneTextController.dispose(); // Dispose of TextEditingController
    passwordTextController.dispose(); 
    super.dispose();
  }
}
