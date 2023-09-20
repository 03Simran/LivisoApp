
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;

import '../utils/colors.dart';
import 'package:liviso_flutter/widgets/room.dart';

class ProfileWidget extends StatefulWidget {
  final String label;
  final String initialValue ;
  final bool isShopLink ;
  final String param ;
  final String id ;
  final Function(String,String) onSave;


  const ProfileWidget({
    required this.label,
    required this.initialValue,
    required this.isShopLink,
    required this.param,
    required this.id,
    required this.onSave,
    super.key});

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {

  bool isEditing = false;
  late TextEditingController textEditingController;
  late String editedText;

  

  @override
  void initState() {
  super.initState();
  textEditingController = TextEditingController(text: widget.initialValue);
  editedText = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Stack( 

        children: [
         Container(
          width : 329.w,
          height : 80.99.h,
          decoration : BoxDecoration(
            color : Colors.white,
            border: Border.all(color: Colors.white, width : 0)
          )
         ),

          Positioned(
            top : 15.h,
            left : 15.w,
            child: Container(
            width : 299.w,
            height : widget.isShopLink? 55.h : 50.99.h,
            decoration : BoxDecoration(
              borderRadius: BorderRadius.circular(5.r),
              border : Border.all(color: ThemeColors.textColor6,
              width : 0.5 ),
                
            ),
            padding : EdgeInsets.symmetric(vertical : 12.h, horizontal: 12.w),
            child : Row (
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                widget.isShopLink 
                ? Container(
                  constraints: BoxConstraints(
                    maxWidth: 250.h
                  ),
                  child: Text( widget.initialValue, 
                                          maxLines: 2, // Set the maximum number of lines
                                          overflow: TextOverflow.ellipsis,
                                          style : GoogleFonts.poppins(
                                            textStyle: TextStyle (color: ThemeColors.textColor7,
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.w300)
                                          ) // Truncate text with ellipsis (...) if it doesn't fit within the two lines
                                        ),
                )
                

              :  isEditing 
                ? Flexible(
                  child: TextField(
                    
                    controller: textEditingController,
                    style:GoogleFonts.poppins(
                      textStyle: TextStyle (
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500
                    )
                    ),
                    decoration: InputDecoration(
                
                    ),
                    onChanged: (value) {
                      setState(() {
                        editedText = value;
                      });
                    },
                  ),
                )
                : Text(widget.initialValue , 
                style : GoogleFonts.poppins(
                  textStyle: TextStyle (
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500
                  )
                )),
                

                Spacer(),
                Center(child: 
                widget.isShopLink ?
                CopyTextButton(

                )
                : isEditing 
                ? IconButton(
                  onPressed: (){
                    widget.onSave(editedText, widget.param);
                    setState(() {
                      isEditing=false;
                    });
                  }, icon:
                 Icon(Icons.save, size: 15,))

                 : IconButton(onPressed: (){
                  setState(() {
                    isEditing = true;
                  });
                 },
                  icon: Icon(Icons.edit, size: 15,))
                 )
                 
              ],
            )
                  ),
          ),

        Positioned(top : 0,
        left : 25.w, 
        child: Container(
          padding : EdgeInsets.all(5.w),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 0,
            color: Colors.white,)
          ),
          child : Text(widget.label, 
          style : GoogleFonts.poppins(
            textStyle: TextStyle(fontSize: 8.5.sp,
            fontWeight: FontWeight.normal)
          )),
        ) ),
        ]
      )
      ;
    
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

}



