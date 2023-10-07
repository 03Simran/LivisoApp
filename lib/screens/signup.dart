// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:liviso_flutter/screens/add_profile.dart';
import 'package:liviso_flutter/utils/colors.dart';
import 'package:liviso_flutter/widgets/login_widgets.dart';
import 'package:liviso_flutter/screens/login.dart';



class SignUpScreen extends StatefulWidget {
 
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
   final GlobalKey<FormState> phonekey = GlobalKey<FormState>();


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
    if (phonekey.currentState!.validate()) {
      final String name = nameTextController.text;
      final String email = emailTextController.text;
      final String phone = phoneTextController.text;

           Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => AddProfileScrn(name :name, email: email, phone : phone,),

        //Scale Transition
       transitionsBuilder: (context, animation, secondaryAnimation, child) {
  const begin = 0.0;
  const end = 1.0;
  var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: Curves.easeInOut));

  var scaleAnimation = animation.drive(tween);

  return ScaleTransition(
    scale: scaleAnimation,
    child: child,
  );
},
      ),
    );
  
          


    //   final Map<String, dynamic> data = {
    //      "name":name,
    // "phone":phone,
    // "email":email

    //   };

    //   final String jsonData = jsonEncode(data);

    //   try {
    //     setState(() {
    //       isLoading= true;
    //     });
    //     final response = await http.post(
    //       Uri.parse('https://stealth-zys3.onrender.com/api/v1/auth/register'),
    //       headers: <String, String>{
    //         'Content-Type': 'application/json; charset=UTF-8',
    //       },
    //       body: jsonData,
    //     );

    //     if (response.statusCode == 201) {
    //       setState(() {
    //         isLoading= false;
    //       });
    //       final Map<String, dynamic> responseBody = json.decode(response.body);
          
    //       ScaffoldMessenger.of(context).showSnackBar(
    //      const SnackBar(content: Text('SignUp Successful')),
    //      );

    //       if (kDebugMode) {
    //         print('Sign Up Successful');
    //       }
    //       userId= responseBody['userId'];
          

          //  Navigator.of(context).push(
          //   MaterialPageRoute(
          //     builder: (context) => AddProfileScrn(name :name, email: email, phone : phone,),
          //   ),
          // );
          
        // } else {
        //   setState(() {
        //     isLoading= false;
        //   });
        //   final Map<String, dynamic> responseBody = json.decode(response.body);
        //   ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(content: Text(responseBody['message'])),
        //  );


        //   if (kDebugMode) {
        //     print('Failed to send profile data. Status code: ${response.body}');
        //   }
        // }
      // } catch (e) {
      //   setState(() {
      //     isLoading=false;
      //   });
      //   ScaffoldMessenger.of(context).showSnackBar(
      //    const SnackBar(content: Text('An error occured. Try Again')),
      //    );
      //   if (kDebugMode) {
      //     print('Error sending profile data: $e');
      //   }
        
      // }
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
                key: phonekey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 120.h,),
                    Logo(height: 100.h,width: 200.w,),
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
                            
           Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
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
    //                 : SizedBox(
    //   width: 310.w,
    //   height: 50.h,
    //   child: FloatingActionButton(
    //       onPressed: null,
    //       backgroundColor: 
    //            ThemeColors.primaryColor,
              
    //       foregroundColor: Colors.white,
    //       shape: ContinuousRectangleBorder(
    //           borderRadius: BorderRadius.circular(10.r)),
    //       child: const Center(
    //         child : CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(
    //                     Colors.white),)
    //       )),
    // ),

                    SizedBox(height: 50.h,)
                  ],
                ),
                
              ),
            ),
          ),
        
      ),
    );
  }


  @override
  void dispose() {
    // Dispose of resources here
    phonekey.currentState?.dispose(); // Dispose of FormState
    phoneTextController.dispose(); // Dispose of TextEditingController
    emailTextController.dispose(); 
    nameTextController.dispose(); 
    super.dispose();
  }
   
  
}
