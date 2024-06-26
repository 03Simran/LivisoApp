// ignore_for_file: use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:liviso_flutter/main.dart';
import 'package:liviso_flutter/screens/home_scrn.dart';
import 'package:liviso_flutter/screens/video_call.dart';

import 'package:liviso_flutter/widgets/login_widgets.dart';
import 'package:provider/provider.dart';

class IncomingCallNotification extends StatelessWidget {
  final String incomingCall;
  final String roomName;

  const IncomingCallNotification(
      {super.key, required this.incomingCall, required this.roomName});

  void showNotification(
      BuildContext context, String incomingCallNo, String roomName) {
    OverlayState? overlayState = Overlay.of(context);
    OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 0,
        left: 0,
        right: 0,
        bottom: 0,
        child: IncomingCallNotification(
          incomingCall: incomingCallNo,
          roomName: roomName,
        ),
      ),
    );

    overlayState.insert(overlayEntry);

    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            color: const Color.fromRGBO(236, 242, 246, 1),
            padding: EdgeInsets.fromLTRB(35.h, 70.h, 35.h, 70.h),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5), // Shadow color
                    spreadRadius: 2, // Spread radius
                    blurRadius: 5, // Blur radius
                    offset: const Offset(0, 3), // Offset in x and y direction
                  ),
                ],
              ),
              padding: EdgeInsets.all(5.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 130.h,
                  ),
                  const TextHd(text: 'Incoming Call from'),
                  SizedBox(
                    height: 50.h,
                  ),
                  TextHd(text: incomingCall),
                  SizedBox(
                    height: 150.h,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () async {

                          String userId;
                           UserIdProvider userIdProvider = context.read<UserIdProvider>();
                           userId = userIdProvider.userId ; 
                          if (kDebugMode) {
                            print(roomName);
                          }
                          final response = await http.post(
                            Uri.parse(
                                'https://stealth-zys3.onrender.com/api/v1/video/manage?roomName=$roomName&isAccepted=true&id=$userId&phone=$incomingCall'),
                          );

                          // print(incomingCall);
                          // print(userId);
                          // print(roomName);

                          // if (response.statusCode == 200) {
                          //   print(response.body);
                          // } else {
                          //   // print(response.statusCode);
                          //   // print(response.body);
                          // }

                           Navigator.pop(context);

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VideoCallScreen(
                                callID: roomName,
                                roomName: roomName,
                              ),
                            ),
                          );

                        },
                        child: CircleAvatar(
                          radius: 30.r,
                          backgroundColor: Colors.green,
                        ),
                      ),
                      SizedBox(
                        width: 70.w,
                      ),
                      GestureDetector(
                        onTap: () async {
                          String userId;
                           UserIdProvider userIdProvider = context.read<UserIdProvider>();
                           userId = userIdProvider.userId ; 
                          if (kDebugMode) {
                            print(roomName);
                          }
                          final response = await http.post(
                            Uri.parse(
                              'https://stealth-zys3.onrender.com/api/v1/video/manage?roomName=$roomName&isRejected=true&id=$userId&phone=$incomingCall',
                            ),
                          );

                          // if (response.statusCode == 200) {
                          //   print(response.body);
                          // } else {
                          //   print(response.statusCode);
                          // }
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeScreen1(id: userId),
                            ),
                          );
                        },
                        child: CircleAvatar(
                          radius: 30.r,
                          backgroundColor: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            )),
      ),
    );
  }
}
