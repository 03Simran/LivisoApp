import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:liviso_flutter/api/meeting_api.dart';
import 'package:liviso_flutter/models/meeting_detail.dart';
import 'package:liviso_flutter/joinScreen.dart';
//import 'package:liviso_flutter/services/socketConnection.dart';

class JoinMeetingPage extends StatefulWidget {
  
  const JoinMeetingPage({super.key});

  @override
  State<JoinMeetingPage> createState() => _JoinMeetingPageState();
}

class _JoinMeetingPageState extends State<JoinMeetingPage> {
  static final GlobalKey<FormState> joinMeetKey = GlobalKey<FormState>();
  String meetingId ="";
  TextEditingController meetIdController = TextEditingController();

  @override
 Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar( // Optional: Add an app bar if needed
      title: Text('Meeting App'),
    ),
    body: Center(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: joinMeetKey,
          child: Column(
            children: [
              SizedBox(height: 20),
              Text('Join or start a meeting'),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Enter the meeting id',
                  hintText: '89dg8fs89f4f5f5',
                ),
                controller: meetIdController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "MeetingId cannot be null";
                  } else {
                    return null;
                  }
                },
                onSaved: (newValue) {
                  meetingId = newValue!;
                },
              ),
              Row(
                children: [
                  ElevatedButton(
                    child: Text('Start Meeting'),
                    onPressed: () async {
                     var response =  await startMeeting();
                    if (response != null) {
                  final body = json.decode(response.body);
                     final meetingId = body["data"];
                     validateMeeting(meetingId);
  // Use the decoded JSON as needed
} else {
 print("Null Response ");
}
                    },
                  ),
                  SizedBox(width: 40),
                  ElevatedButton(
                    child: Text("Join  Meeting"),
                    onPressed: () {
                      if(validateAndSave()){
                        validateMeeting(meetingId); 
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

void validateMeeting(String meetingId) async{
  try{
    Response? response = await joinMeeting(meetingId);
    var data = json.decode(response!.body);
    final meetingDetails =MeetingDetail.fromJson(data["data"]);
    gotoJoinScreen(meetingDetails);
  }
  catch(err){
    print("Error in joining meeting");
  }

}

gotoJoinScreen(MeetingDetail meetingDetail){
  Navigator.pushReplacement(context,  
  MaterialPageRoute(builder: (context)=> JoinScreen(
    meetingDetails: meetingDetail,
    meetingId: meetingId,
  )));
}

bool validateAndSave() {
  final form = joinMeetKey.currentState;
  if (form!.validate()) {
    form.save();
    return true;
  } else {
    return false;
  }
}

}