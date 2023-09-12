// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:liviso_flutter/Extras/create_room.dart';
import 'package:liviso_flutter/room.dart';
import 'package:liviso_flutter/screens/video_call.dart';
import 'package:liviso_flutter/widget.dart';
import 'package:liviso_flutter/home.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Room',style : TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500
        )),
        backgroundColor: Color.fromARGB(255, 31, 5, 90),),

      body: Padding(
        padding: const EdgeInsets.all(13),

        child: Container(
          
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                 Row(children: [
                  Text('Recent Calls'),
                  Spacer(),
                  TextButton(onPressed: (){
                    Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          CreateRoom(),
                    ),
                  );
                  }, child: Text('Create Room ->',
                  style : TextStyle(
                    color: Colors.black
                  )))
                 ],),
        
                 CallElement(),
                 CallElement(),
                 CallElement(),
                 CallElement(),
        
                
        
                 
              ],
            ),
        ),
      ),
      
    );
  }
}
