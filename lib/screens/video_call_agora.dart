import 'package:agora_uikit/agora_uikit.dart';



import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VideoAgora extends StatelessWidget {
  
 final AgoraClient _client = AgoraClient(
    agoraConnectionData: AgoraConnectionData(
      appId: "71b80a81ce4244f0b1185ac5cdbc0e3f", 
      channelName: "Aks",
      tempToken: "007eJxTYLB7U1ozbwJD09SD6WVuwr8LeE+FpR7LLfredZlrmvwBfkcFBnPDJAuDRAvD5FQTIxOTNIMkQ0ML08Rk0+SUpGSDVOM0y/0MqQ2BjAzxbF9YGBkgEMRnZnDMLmZgAAD7Ih3t"),
      enabledPermission: [
        Permission.camera,
        Permission.microphone
      ]
  );
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body :SafeArea(
        child: Stack(
          children: [
            AgoraVideoViewer(client: _client),
            AgoraVideoButtons(client: _client)
          ],
        )
      )
    ); 
  }
}