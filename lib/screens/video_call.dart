import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liviso_flutter/main.dart';
import 'package:liviso_flutter/screens/homeScrn.dart';
import 'package:liviso_flutter/screens/profileScrn.dart';
import 'package:liviso_flutter/utils/colors.dart';
import 'package:liviso_flutter/widgets/bottom_navigation.dart';
import 'package:provider/provider.dart';

import 'package:zego_uikit_prebuilt_video_conference/zego_uikit_prebuilt_video_conference.dart';

class VideoCallScreen extends StatefulWidget {
  final String callID;
  final String roomName;

  const VideoCallScreen({
    Key? key,
    required this.callID,
    required this.roomName
  }) : super(key: key);

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  int selectedIndex = 1;
  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });

    if (selectedIndex == 0) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => HomeScreen1(
          id: "",
        ),
      ));
    } else if (selectedIndex == 2) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ProfileScreen(
          user_id: "",
        ),
      ));
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        titleSpacing: -10,
        title: Text(
          'Live Call',
          style: GoogleFonts.poppins(
              textStyle:
                  TextStyle(color: ThemeColors.textColor7, fontSize: 15.sp, fontWeight: FontWeight.w500)),
        ),
      ),
      body: SafeArea(
        child: Container(
          color: ThemeColors.backgroundColor,
         
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.r)),
            child: ZegoUIKitPrebuiltVideoConference(
              appID:
                  1237771667, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
              appSign:
                  '3dcf6738b89de0a75da57243e1d1b6438ff26cbcd479c5a1eb79b3681f996c36', // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
              userID: widget.roomName,
              userName: widget.roomName,
              conferenceID: widget.callID,
              config: ZegoUIKitPrebuiltVideoConferenceConfig(
                
                  turnOnCameraWhenJoining: false,
                  onLeave: () {
                    UserIdProvider userIdProvider = context.read<UserIdProvider>();
                    String userId = userIdProvider.userId;

                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => HomeScreen1(
                        id: userId,
                      ),
                    ));
                  }),

                  
            ),
          ),
        ),
      ),
      bottomNavigationBar: MyBottomNavigationBar(
        onItemTapped: _onItemTapped,
        selectedIndex: 1,
      ),
    );
  }
}
