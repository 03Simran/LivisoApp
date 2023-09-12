import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:liviso_flutter/screens/homeScrn.dart';
import 'package:liviso_flutter/screens/video_call.dart';
import 'package:liviso_flutter/utils/colors.dart';
import 'package:liviso_flutter/widgets/loginWidgets.dart';

class IncomingCallNotification extends StatelessWidget {
  final String incomingCall;
  final String roomName;

  IncomingCallNotification(
      {required this.incomingCall, required this.roomName});

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

    // Handle user interactions (e.g., accepting or rejecting the call) within the IncomingCallNotification widget.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            color: const Color.fromRGBO(236, 242, 246, 1),
            padding: EdgeInsets.fromLTRB(35.h, 70.h,35.h,70.h),
            
            child: Container(
              decoration: BoxDecoration(
                 
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.r),
                   boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey
                                        .withOpacity(0.5), // Shadow color
                                    spreadRadius: 2, // Spread radius
                                    blurRadius: 5, // Blur radius
                                    offset: Offset(
                                        0, 3), // Offset in x and y direction
                                  ),
                                ],),
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
                          print(this.roomName);
                          final response = await http.post(
                            Uri.parse(
                                'https://stealth-zys3.onrender.com/api/v1/video/manage?isAccepted=true&roomName=${this.roomName}'),
                          );

                          if (response.statusCode == 200) {
                            print('AAAEEEEEEEEEEEEEE');
                            print(response.body);

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    VideoCallScreen(callID: this.roomName),
                              ),
                            );
                          }
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
                          print(this.roomName);
                          final response = await http.post(
                            Uri.parse(
                                'https://stealth-zys3.onrender.com/api/v1/video/manage?isRejected=true&roomName=${this.roomName}'),
                          );

                          if (response.statusCode == 200) {
                            print('AAAEEEEEEEEEEEEEE');
                            print(response.body);

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                   HomeScreen1(id: ''),
                              ),
                            );
                          }
                        },
                        child: CircleAvatar(
                          radius : 30.r,
                          backgroundColor: Colors.red,
                        ),
                      ),
                    ],
                  ),
                 
                  SizedBox(height: 20),
                 
                ],
              ),
            )),
      ),
    );
  }
}
