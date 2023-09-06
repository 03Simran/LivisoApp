import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:liviso_flutter/api/meeting_api.dart';
import 'package:liviso_flutter/models/meeting_detail.dart';
import 'package:liviso_flutter/screens/meeting_page.dart';

class JoinScreen extends StatefulWidget {
  final MeetingDetail meetingDetails;
  final meetingId;
  const JoinScreen({required this.meetingDetails,required this.meetingId,super.key});

  @override
  State<JoinScreen> createState() => _JoinScreenState();
}

class _JoinScreenState extends State<JoinScreen> {
  static final GlobalKey<FormState> joinKey = GlobalKey<FormState>();
  String userName  ="";
  TextEditingController userNameController = TextEditingController();

  @override
 Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar( // Optional: Add an app bar if needed
      title: Text('Join  Meeting'),
    ),
    body: Center(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: joinKey,
          child: Column(
            children: [
              SizedBox(height : 20),
               
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'userId',
                  hintText: 'Enter your name',
                ),
                controller: userNameController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Username cannot be null";
                  } else {
                    return null;
                  }
                },
                onSaved: (newValue) {
                  userName = newValue!;
                },
              ),
              Row(
                children: [
                  
                  ElevatedButton(
                    child: Text("Join  Meeting"),
                    onPressed: () {
                      if(validateAndSave()){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>
                           MeetingPage(meetingId: widget.meetingId,
                           meetingDetail: widget.meetingDetails,
                           name: userName,)
                        

                        ));
                      }
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    ),
  );
}

bool validateAndSave() {
  final form = joinKey.currentState;
  if (form!.validate()) {
    form.save();
    return true;
  } else {
    return false;
  }
}
}