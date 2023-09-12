import 'dart:convert';

import 'package:http/http.dart' as http ;
import 'package:liviso_flutter/utils/user.utils.dart';

String MEETING_URL = "https://liviso.onrender.com/api/v1/meeting";

var client = http.Client();


Future<http.Response?> startMeeting() async {
  Map<String, String> requestHeaders = {
    "Content-type": 'application/json',
  };

  var userId = await loadUserId(); // Await the Future to get the actual userId
  var response = await http.post(Uri.parse('$MEETING_URL/start'),
      headers: requestHeaders,
      body: jsonEncode({'hostId': userId, 'hostName': ''}));
  
  if (response.statusCode == 200) {
    print(response.body);
    return response;
  } else {
    return null;
  }
}


Future<http.Response?> joinMeeting(String meetingId) async {
 
 var response = await http.post(Uri.parse('$MEETING_URL/join?meetingid=$meetingId'),
 
 );
 if(response.statusCode >= 200 && response.statusCode < 400){
  return response;
 }
  
  throw UnsupportedError('Not a valid meeting');
}


