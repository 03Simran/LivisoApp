import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liviso_flutter/widgets/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class Logo extends StatelessWidget {
  final double fontSize; // Add a named parameter for font size

   Logo({Key? key, this.fontSize = 44}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text('LIVISO',
        style:  GoogleFonts.slackey(
          textStyle: TextStyle(
            color: ThemeColors.primaryColor,
            fontSize: 44.sp
          )
        ),
            
            );
  }
}

//HeadingText
class TextHd extends StatelessWidget {
  final String text;

  const TextHd({required this.text, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: GoogleFonts.poppins(
          textStyle: TextStyle(
            
            fontSize: 24.sp,
          )
        ),);
  }
}

//textField

class FormFields extends StatefulWidget {
  final String label;

  const FormFields({required this.label, Key? key}) : super(key: key);

  @override
  State<FormFields> createState() => _FormFieldsState();
}

class _FormFieldsState extends State<FormFields> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      
      style: GoogleFonts.poppins(
        textStyle : TextStyle(
        fontSize: 16.sp,
      )),
      decoration: InputDecoration(
          
          contentPadding: EdgeInsets.all(13.w),
          labelText: widget.label,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(
                  
                  color: const Color(0xFF1C1C1C),
                  width: 0.5.w,
                  style: BorderStyle.solid))),
    );
  }
}

//MainButton

class ButtonMain extends StatefulWidget {
  final bool enabled;
  final String label;
  const ButtonMain({required this.enabled, required this.label,Key? key}) : super(key: key);

  @override
  State<ButtonMain> createState() => _ButtonMain();
}

class _ButtonMain extends State<ButtonMain> {
 

  @override
  Widget build(BuildContext context) {
    return Container(
        width:310.w,
        height : 50.h,
      child: FloatingActionButton(onPressed: (){},
        backgroundColor:  widget.enabled? ThemeColors.primaryColor : ThemeColors.primaryLight,
        foregroundColor: Colors.white,
        shape :ContinuousRectangleBorder (borderRadius: BorderRadius.circular(10.r)),
        
        
        child: Text(widget.label,
        
      style: GoogleFonts.poppins(
        textStyle : TextStyle(
        fontSize: 20.sp,
      )))
      
      ),
    );
  }
}


//Link detector

class ExternalLink extends StatelessWidget {
  final String text;
  final String link;
  const ExternalLink({required this.text,required this.link, Key? key}) : super(key: key);
   
  _launchURL() async {
    String url =link;
    await launchUrl(Uri.parse(url),
    mode: LaunchMode.platformDefault,
    );
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap :_launchURL,
      child : Text(text,
      style: GoogleFonts.poppins(
                textStyle : TextStyle(
                fontSize: 13.sp,
                color: ThemeColors.primaryColor
               )))
    );
  }
}