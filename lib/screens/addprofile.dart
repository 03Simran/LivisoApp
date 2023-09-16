import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liviso_flutter/screens/homeScrn.dart';
import 'package:liviso_flutter/screens/signup.dart';
import 'package:liviso_flutter/utils/colors.dart';
import 'package:liviso_flutter/widgets/loginWidgets.dart';
import 'package:http/http.dart' as http;
import 'package:liviso_flutter/screens/login.dart';


class AddProfileScrn extends StatefulWidget {
static final GlobalKey<FormState> profileKey = GlobalKey<FormState>();
  final String id;
  const AddProfileScrn
({required this.id,
      Key? key});

  @override
  State<AddProfileScrn
> createState() => _AddProfileScrnState();
}

class _AddProfileScrnState extends State<AddProfileScrn> {
  bool isLoading = false;

  String? validateRequiredvalues(String? value) {
     if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }
  
  
  String? validateNonRequiredvalues(String? value) {
     return null;
  }


   var nameController = TextEditingController();        
   var comNameController = TextEditingController();        
   var comWebController = TextEditingController();      
    var comSocController = TextEditingController();   

    Future<void> _submitProfile() async {

      

    if (AddProfileScrn.profileKey.currentState!.validate()) {

      setState(() {
        isLoading = true;
      });
    
      final String companyName = comNameController.text;
      final String companyWebsite = comWebController.text;
      final String companySocialMedia = comSocController.text;

      final Map<String, dynamic> data = {
        
        "shopName": companyName,
        "webLink": companyWebsite,
        "socialLink":companySocialMedia

      };

      final String jsonData = jsonEncode(data);
      print(widget.id);

      try {
        final response = await http.post(
          Uri.parse('https://stealth-zys3.onrender.com/api/v1/auth/profile/${widget.id}'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonData,
        );

        if (response.statusCode == 200) {
          print('Profile data sent successfully.');
           setState(() {
             isLoading= false;
           });
           ScaffoldMessenger.of(context).showSnackBar(
         const SnackBar(content: Text('Profile Saved Successfully')),
         );
          
           Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => LoginScreen(),
            ),
          );
          
        } else {
           setState(() {
             isLoading= false;
           });
          print('Failed to send profile data. Status code: ${response.body}');
        }
      } catch (e) {
       setState(() {
         isLoading= false;
       });
       ScaffoldMessenger.of(context).showSnackBar(
         const SnackBar(content: Text('An error occured. Try Again')),
         );
        print('Error sending profile data: $e');
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold (
        body : SafeArea(
          child: Container (
             height: double.infinity,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 23.w, vertical: 0),
            child : SingleChildScrollView(
              child: Form(
                key : AddProfileScrn
              .profileKey,
                child: Column (
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                  SizedBox(height : 80.h),
                  
                  TextHd(text: 'Complete the profile'),

                  SizedBox(height : 40.h),
                     FormFields(label: 'Company Name', hint: 'XYZ ', enabled: true, controller: comNameController, validateFunction:validateRequiredvalues ),
                       SizedBox(height : 25.h),
                     FormFields(label: 'Company Website', hint: 'www.comp.com', enabled: true, controller: comWebController, validateFunction:validateNonRequiredvalues ),
                     SizedBox(height : 25.h),
                     FormFields(label: 'Social Media ', hint: 'www.instagram.com//simran-01', enabled: true, controller: comSocController, validateFunction:validateNonRequiredvalues ),
 SizedBox(height : 200.h),

                      TextButton(
                          onPressed: () {
                            
           Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => SignUpScreen(),
            ) );
                          },
                          child: Text(
                            'Back to SignUp',
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    fontSize: 16.sp,
                                    color: ThemeColors.primaryColor)),
                          ),
                        ),

                      SizedBox(height: 2.h,),
                    !isLoading ?
                     ButtonMain(enabled: true,
                      label: 'Save Profile',
                       onPressed:  _submitProfile )
                       : SizedBox(
      width: 310.w,
      height: 50.h,
      child: FloatingActionButton(
          onPressed: null,
          backgroundColor: 
               ThemeColors.primaryColor,
              
          foregroundColor: Colors.white,
          shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(10.r)),
          child: const Center(
            child : CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.white),)
          )),
    ),
                ],),
              ),
            )
          ),
        )
      
    );
  }
}