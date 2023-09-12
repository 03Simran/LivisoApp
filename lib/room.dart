
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:liviso_flutter/Extras/create_room.dart';
import 'package:liviso_flutter/services/notif.dart';
import 'package:liviso_flutter/screens/video_call.dart';
import 'package:flutter/services.dart';
import 'package:liviso_flutter/utils/incoming_call.dart';

String _roomLink = ' ';

class CopyTextButton extends StatelessWidget {
  final String textToCopy = _roomLink;

  void _copyToClipboard(BuildContext context) {
    Clipboard.setData(ClipboardData(text: textToCopy));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Text copied to clipboard')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => _copyToClipboard(context),
      icon: Icon(Icons.content_copy),
      
    );
  }
}

class CreateRoom extends StatefulWidget {
  const CreateRoom({super.key});

  @override
  State<CreateRoom> createState() => _CreateRoomState();
}

class _CreateRoomState extends State<CreateRoom> {
  
  String roomId =' ';

  bool _isLoading = false;

  void _onCreateRoomButtonPressed() async {
    setState(() {
      _isLoading = true; 
    });
    try {
      Map<String, dynamic> roomData = await ZegoCloudApi.createRoom();
      if (roomData.containsKey('roomLink')) {
        String roomLink = roomData['roomLink'];
        String roomId = roomData['roomId'];

        setState(() {
          _roomLink = roomLink;
          this.roomId = roomId;
        });

      } else {
        print('Room link not received in response');
      }
    } catch (e) {
      print('Error creating room: $e');
    }
    finally {
      setState(() {
        _isLoading = false; 
      });
    }
  }
  
  void navigateToVideoCall(){
    Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        VideoCallScreen(callID:roomId ),
                  ),
                );
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: 
    Scaffold(appBar: 
    AppBar(title: Text('Create Room', style: TextStyle(
      color: Colors.white
    ),),
    backgroundColor: Color.fromARGB(255, 31, 5, 90),),
    body : Center(
      child : Column (
        mainAxisAlignment: MainAxisAlignment.center,
        children : [
          ElevatedButton(
                onPressed: _isLoading ? null : _onCreateRoomButtonPressed,
                child: Text('Create Room'),
              ),
              SizedBox(height: 20),
      
              if (_isLoading) CircularProgressIndicator(),
              SizedBox(height: 20,),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      width : 200,
                      child: Text('Room Link: $_roomLink',
                      softWrap: true,),
                    ),
                  ),
                  Spacer(),
                  CopyTextButton(),
                  SizedBox(width:20.0),
                  
                ],
              ),
      
              SizedBox(height: 20),

             if (_roomLink.isNotEmpty) ElevatedButton(
                onPressed: (){
                //    Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) =>
                //          IncomingCallNotification(incomingCall: 'Simran',),
                //   ),
                // );
                },
                child: Text(' Notif '),
              ),
        ],)
    )));
  }
}