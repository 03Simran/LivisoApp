import 'package:flutter/material.dart';

class ControlPanel extends StatelessWidget {
  

  final bool? isVideoEnabled ;
 final bool? isAudioEnabled;
 final bool? isConnectionFailed;
  final VoidCallback? onVideoToggle;
   final VoidCallback? onAudioToggle;
    final VoidCallback? onReconnect;
     final VoidCallback? onMeetingEnd;

    ControlPanel({
      this.isVideoEnabled,
      this.isAudioEnabled,
      this.onVideoToggle,
      this.onAudioToggle,
      this.isConnectionFailed,
      this.onReconnect,
      this.onMeetingEnd,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color : Colors.blueGrey[900],
      height : 60.0,
      child : Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children : buildControls(),)
    );
}

List<Widget> buildControls(){
      if(!isConnectionFailed!){
         return <Widget> [
          IconButton(
            onPressed: onVideoToggle,
            icon : Icon(isVideoEnabled! ? Icons.videocam : Icons.videocam_off),
            color : Colors.white,
            iconSize: 32.0,),
            IconButton(
            onPressed: onAudioToggle,
            icon : Icon(isAudioEnabled! ? Icons.mic : Icons.mic_off),
            color : Colors.white,
            iconSize: 32.0,),
            
            const SizedBox(width : 25),

            Container(
              width: 70,
              height: 30,
              decoration: BoxDecoration(
                color : Colors.red,
                borderRadius: BorderRadius.circular(10)
              ),
              child : IconButton(
                onPressed: onMeetingEnd,
              icon : const Icon(
                Icons.call_end,
                color : Colors.white,

              ))
            )

         ];
      }
      else {
        return <Widget> [
          Container(
            child : IconButton(icon: Icon(Icons.refresh),
            onPressed: onReconnect,)
          )
        ]; 
      }
    }
  }
