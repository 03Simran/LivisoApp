// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:liviso_flutter/models/meeting_detail.dart';

import 'package:flutter_webrtc_wrapper/flutter_webrtc_wrapper.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:liviso_flutter/screens/homeScrn.dart';
import 'package:liviso_flutter/utils/user.utils.dart';
import 'package:liviso_flutter/widgets/control_panel.dart';
import 'package:liviso_flutter/remote_connection.dart';

class MeetingPage extends StatefulWidget {

  final String? meetingId; 
  final String? name;
  final MeetingDetail meetingDetail;

  MeetingPage({Key? key, this.meetingId, this.name, required this.meetingDetail});
  
   @override
  State<MeetingPage> createState() => _MeetingPageState();
}

class _MeetingPageState extends State<MeetingPage> {

  final _localRenderer = RTCVideoRenderer();
  final Map<String,dynamic> mediaConstraints = {
    "audio": true,
    "video": true
  };
  bool isConnectionFailed =false;
  WebRTCMeetingHelper? meetingHelper;

  @override
  Widget build(BuildContext context) {
     return Scaffold(backgroundColor: Colors.black,
      body : _buildMeetingRoom(),
      bottomNavigationBar: ControlPanel(
        isAudioEnabled: isAudioEnabled(),
        isVideoEnabled: isVideoEnabled(),
        onAudioToggle: onAudioToggle,
        onVideoToggle: onVideoToggle,
        isConnectionFailed: isConnectionFailed,
        onReconnect: handleReconnect,
        onMeetingEnd: onMeetingEnd,
        ),);
  }

    void startMeeting() async {
      final String userId = await loadUserId();
     meetingHelper = WebRTCMeetingHelper(
        url :"https://liviso.onrender.com",
        meetingId: widget.meetingId,
        userId: userId,
        name : widget.name
      );

      MediaStream _localStream = await navigator.mediaDevices.getUserMedia(mediaConstraints);
      _localRenderer.srcObject =_localStream;
      meetingHelper?.stream = _localStream;

      meetingHelper!.on(
        "open",
        context,
        (ev,context){
          setState((){
            isConnectionFailed=false;
          });
        });

        meetingHelper!.on(
        "connection",
        context,
        (ev,context){
          setState((){
            isConnectionFailed=false;
            print("CONNECTION");
          });
        });

        meetingHelper!.on(
        "user-left",
        context,
        (ev,context){
          setState((){
            isConnectionFailed=false;
          });
        }); 

        meetingHelper!.on(
        "video-toggle",
        context,
        (ev,context){
          setState((){
            isConnectionFailed=false;
          });
        });

 
      meetingHelper!.on(
        "audio-toggle",
        context,
        (ev,context){
          setState((){
            isConnectionFailed=false;
          });
        });

        meetingHelper!.on(
        "meeting-ended",
        context,
        (ev,context){
          onMeetingEnd();
        });

        meetingHelper!.on(
        "connection-setting-changed",
        context,
        (ev,context){
          setState((){
            isConnectionFailed=false;
          });
        });

        meetingHelper!.on(
        "stream-changed",
        context,
        (ev,context){
          setState((){
            isConnectionFailed=false;
          });
        });

        setState(() {
          
        });
    }
     
     initRenderers() async{
       await _localRenderer.initialize();
     }

     @override
     void initState(){
      super.initState();
      initRenderers();
      startMeeting();
     }

     @override 
     void deactivate(){
      super.deactivate();
      _localRenderer.dispose();
      if(meetingHelper != null){
        meetingHelper!.destroy();
        meetingHelper=null;
      }
     }
  
  void onMeetingEnd() {
     if(meetingHelper != null){
     meetingHelper?.endMeeting();
     meetingHelper = null;
     gotoHomePage();
      
    }
  }
  
  isVideoEnabled() {
     return meetingHelper != null ? meetingHelper!.videoEnabled! : false;
  }

  onAudioToggle() {
     if(meetingHelper != null){
      setState(() {
        meetingHelper?.toggleAudio();
      });
    }
}

bool isAudioEnabled() {
  return meetingHelper != null ? meetingHelper!.audioEnabled! : false;
}

_buildMeetingRoom() {

  return Stack(
    children: [
      meetingHelper != null && meetingHelper!.connections.isNotEmpty ? 
      GridView.count(crossAxisCount: meetingHelper!.connections.length < 3 ? 1 :2,
      children: List.generate(meetingHelper!.connections.length, (index) {
        return Padding(padding: const EdgeInsets.all(1),
        child : RemoteConnection(connection: meetingHelper!.connections[index],
        renderer: meetingHelper!.connections[index].renderer,));
      } ),) : const Center(child: Padding(padding: EdgeInsets.all(10),
      child: Text('Waiting for participants to join',
      style: TextStyle(color: Colors.white),),),) ,

      Positioned(bottom :10, right : 0,
      child : SizedBox(width: 150,
      height: 200,child: RTCVideoView(_localRenderer),))
    ],
    );
}

  onVideoToggle() {
    if(meetingHelper != null){
      setState(() {
        meetingHelper?.toggleVideo();
      });
    }
  }


  void handleReconnect() {
    if(meetingHelper != null){
      meetingHelper!.reconnect();
    }
  }

  void gotoHomePage(){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const HomeScreen1(id : "jbbdiej")));
  }
}

