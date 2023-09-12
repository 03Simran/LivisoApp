import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:liviso_flutter/screens/addprofile.dart';
import 'package:liviso_flutter/utils/colors.dart';
import 'package:liviso_flutter/widgets/loginWidgets.dart';
import 'package:liviso_flutter/screens/login.dart';



class SignUpScreen extends StatefulWidget {
  static final GlobalKey<FormState> phonekey = GlobalKey<FormState>();

  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

   late final String user_id;
  
  final TextEditingController phoneTextController = TextEditingController();
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController nameTextController = TextEditingController();

  final RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
  final RegExp phoneRegex = RegExp(r'^[0-9]{10}$');
  final RegExp nameRegex = RegExp(r'^[a-zcA-Z- ]+$');

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

  Future<void> _signup() async {
    if (SignUpScreen.phonekey.currentState!.validate()) {
      final String name = nameTextController.text;
      final String email = emailTextController.text;
      final String phone = phoneTextController.text;

      final Map<String, dynamic> data = {
         "name":name,
    "phone":phone,
    "email":email

      };

      final String jsonData = jsonEncode(data);

      try {
        final response = await http.post(
          Uri.parse('https://stealth-zys3.onrender.com/api/v1/auth/register'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonData,
        );

        if (response.statusCode == 201) {
          final Map<String, dynamic> responseBody = json.decode(response.body);
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
         const SnackBar(content: Text('Password sent to your email')),
         );

          print('Sign Up Successful');
          user_id= responseBody['userId'];
          

           Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddProfileScrn(id: user_id,),
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
                key: SignUpScreen.phonekey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 120.h,),
                    Logo(fontSize: 44.sp,),
                    SizedBox(height: 52.h,),
                    const TextHd(text: 'Become a partner'),
                    SizedBox(height: 58.h),
                    FormFields(
                      label: 'Phone Number',
                      hint: '9999999999',
                      enabled: true,
                      controller: phoneTextController,
                      validateFunction: validatePhoneNumber,
                    ),
                    SizedBox(height: 20.h,),
                    FormFields(
                      label: 'Email',
                      hint: 'someone@gmail.com',
                      enabled: true,
                      controller: emailTextController, 
                      validateFunction: validateEmail,// Create a new controller if needed
                    ),
                    SizedBox(height: 20.h),
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
                          onPressed: () {
                            
           Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => LoginScreen(),
            ) );
                          },
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
                      label: 'Proceed',
                      onPressed: _signup
                      
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
