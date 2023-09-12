import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class CallElement extends StatelessWidget {
  const CallElement({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.all(5),
      height:50,
      width: double.infinity,
      padding: EdgeInsets.all(2),
      decoration:BoxDecoration(
        color: Color.fromARGB(255, 205, 229, 240),
        borderRadius: BorderRadius.circular(8)
        ),
        
        child: Row(

          children: [

          SizedBox(width:7),
          
          Icon(Icons.arrow_circle_left,size: 20),

          SizedBox(width: 7),

          Text('66666666660',
          style : GoogleFonts.poppins(
            textStyle : TextStyle (
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.red
            )
          )),
           
           Spacer(),
          
          Column( 
            crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('durn',
          style : GoogleFonts.poppins(
            textStyle : TextStyle (
              fontSize: 9,
              fontWeight: FontWeight.w500,
              color: Colors.black
            )
          )),
            Text('durnbhr nf4infomni',
          style : GoogleFonts.poppins(
            textStyle : TextStyle (
              fontSize: 9,
              fontWeight: FontWeight.w500,
              color: Colors.black
            )
          )),
          ],),

          SizedBox(width: 7)
        ],)
    );
  }
}