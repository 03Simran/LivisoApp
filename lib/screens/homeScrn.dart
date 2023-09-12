// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:convert';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liviso_flutter/data/data_model.dart';
import 'package:liviso_flutter/screens/video_call.dart';
import 'package:liviso_flutter/services/notif.dart';
import 'package:liviso_flutter/services/notif_service.dart';
import 'package:liviso_flutter/screens/profileScrn.dart';
import 'package:liviso_flutter/services/service_notification.dart';
import 'package:liviso_flutter/utils/colors.dart';
import 'package:liviso_flutter/utils/incoming_call.dart';
import 'package:liviso_flutter/widgets/bottom_navigation.dart';
import 'package:liviso_flutter/widgets/homeWidgets.dart';
import 'package:liviso_flutter/widgets/loginWidgets.dart';
import 'package:http/http.dart' as http;
import 'package:liviso_flutter/models/profile_data.dart';

String callLink = '';


class HomeScreen1 extends StatefulWidget {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  final String id;
  const HomeScreen1({required this.id, super.key});

  @override
  State<HomeScreen1> createState() => _HomeScreen1State();
}

class _HomeScreen1State extends State<HomeScreen1> {

  NotificationServices notificationService = NotificationServices();

  
  
  int selectedIndex = 0;
  bool incomingCall = false;

  final incomingCallNo = '8252645278';
  bool isOpen = false;
  String shopName = 'abcd';
  List<dynamic> callsData = [];

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });

    if (selectedIndex == 0) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => HomeScreen1(
          id: widget.id,
        ),
      ));
    } else if (selectedIndex == 2) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ProfileScreen(
          user_id: widget.id,
        ),
      ));
    } else {
      return;
    }
  }

  @override
  void initState()  {
    super.initState();

     notificationService.requestNotificationsPermission();
     //notificationService.isTokenRefresh();
     notificationService.fireBaseInit(context);
     notificationService.setUpInteractMessage(context);
     notificationService.getDeviceToken().then((value){
       print("Device Token");
       print(value);
     });

    // // Use Future.delayed to run your asynchronous operation
    Future.delayed(Duration.zero, () async {
     ProfileData? response = await fetchProfileData();
     setState(() {
       isOpen = response!.isOpen!;
       shopName = response.shopName;
     callsData = response.calls!;
    callLink = response.shopLink;
    });

    //startPollingApi();
     });
  }

  Future<void> startPollingApi() async {
    const duration = Duration(seconds: 20); // Poll every 10 second

    Timer.periodic(duration, (Timer timer) async {
      try {
        final response = await http.get(
          Uri.parse(
              'https://stealth-zys3.onrender.com/api/v1/video/notify?roomName=$shopName'),
        );

        if (response.statusCode == 200) {
          final Map<String, dynamic> jsonResponse = json.decode(response.body);
          final bool notificationStatus = jsonResponse['isNotified'] ?? false;
          final String userId = jsonResponse['userName'] ?? '';

          if (notificationStatus) {
            // Display a notification if the status is true
            showNotification(userId,shopName);
          }

          // You can use the userId here for any additional logic if needed
        } else {
          debugPrint('Failed to fetch API data');
        }
      } catch (error) {
        debugPrint('Error while parsing API response: $error');
      }
    });
  } 

  Future<void> showNotification(String userId, String roomName) async {
    await NotificationService.showNotification(
        title: "Incoming Call from",
        body: userId,
        payload: {
          "navigate": "true",
        },
        actionButtons: [
          NotificationActionButton(
            key: 'manage',
            label: 'Manage Call',
            actionType: ActionType.SilentAction,
            color: Colors.green,
          )
        ]);
  }

  Future<ProfileData?> fetchProfileData() async {
    final response = await http.get(Uri.parse(
        'https://stealth-zys3.onrender.com/api/v1/auth/getProfile/${widget.id}'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return ProfileData.fromJson(data["user"]);
    } else {
      print("Profile Data not loaded fot Home Screen");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Logo(fontSize: 25.sp),
          titleSpacing: 2.w,
          elevation: 3,
          actions: <Widget>[
            Row(
              children: [
                Text(
                  'Live Calling',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black, // Add desired text color
                    ),
                  ),
                ),
                SizedBox(width: 6.w), // Add spacing between text and icon

                IconButton(
                  onPressed: () async {
                    setState(() {
                      isOpen = !isOpen; // Toggle the value of isOpen
                    });
                    try {
                      final response = await http.post(
                        Uri.parse(
                            'https://stealth-zys3.onrender.com/api/v1/auth/profile/${widget.id}'), 
                        body: {
                          'isOpen': isOpen.toString(),
                        },
                      );

                      if (response.statusCode == 200) {
                        print("Value CHANGED");
                      } else {
                        print("SOME ERROR");
                      }
                    } catch (error) {
                      print('eXCEPTION');
                    }
                  },
                  icon: isOpen
                      ? Icon(
                          Icons.toggle_on,
                          size: 40.h,
                          color: ThemeColors.primaryColor,
                        )
                      : Icon(Icons.toggle_off,
                          color: ThemeColors.textColor7, size: 40.h),
                ),

                SizedBox(
                  width: 12.w,
                ),
              ],
            ),
          ],
        ),
        body: Container(
          padding: EdgeInsets.all(13.w),
          color: ThemeColors.backgroundColor,
          child: Stack(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Recent Calls',
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: ThemeColors.textColor6))),
                SizedBox(height: 17.h),
                Expanded(
                  child: SingleChildScrollView(
                      child: callsData.isEmpty
                          ? Container(
                              margin: EdgeInsets.all(5.h),
                              padding: EdgeInsets.all(10.w),
                              width: double.infinity,
                              height: 160.h,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8.r)),
                              
                              child : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                Text('No Calls Yet!!',
                                style : GoogleFonts.poppins(
                                  textStyle: TextStyle (color: ThemeColors.textColor7,
                                  fontSize: 14.sp)
                                )),
                                SizedBox(height: 10.h,),
                                Text('Start by sharing the shop link with the customers:',
                                maxLines: 2, // Set the maximum number of lines
                                        overflow: TextOverflow.ellipsis,
                                style : GoogleFonts.poppins(
                                  textStyle: TextStyle (color: ThemeColors.textColor7,
                                  fontSize: 13.sp)
                                )),
                                 SizedBox(height: 10.h,),
                                Row (children: [
                                  Text('ShopLink:',
                                style : GoogleFonts.poppins(
                                  textStyle: TextStyle (color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13.sp)
                                )),
                                SizedBox(width: 10.w,),
                                Container(
                                  constraints: BoxConstraints(
                                            maxWidth: 170.0, 
                                       ),
                                  child: Text( callLink, 
                                        maxLines: 2, // Set the maximum number of lines
                                        overflow: TextOverflow.ellipsis,
                                        style : GoogleFonts.poppins(
                                          textStyle: TextStyle (color: ThemeColors.textColor7,
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w300)
                                        ) // Truncate text with ellipsis (...) if it doesn't fit within the two lines
                                      ),
                                ),

                                SizedBox(width: 10.w,),
                                CopyTextButton()


                                ],),
                             //   SizedBox(height: 10.h,),

                                //  TextButton(onPressed: (){
                                //   showNotification(widget.id,"Aks");
                                //  },
                                //  child: Text("Accept or Reject"))
                               
                              ],),
                              
                            )
                          : Column(
                              children: [
                                CallElement(),
                                CallElement(),
                              ],
                            )),
                ),
              ],
            ),
            incomingCall && isOpen
                ? Visibility(
                    visible: true,
                    child: Positioned(
                        top: 70.h,
                        left: 30.w,
                        child: Container(
                            height: 346.h,
                            width: 269.w,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey
                                        .withOpacity(0.5), // Shadow color
                                    spreadRadius: 2, // Spread radius
                                    blurRadius: 5, // Blur radius
                                    offset: Offset(
                                        0, 3), // Offset in x and y direction
                                  ),
                                ],
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.r)),
                            child: Column(
                              children: [
                                SizedBox(height: 45.h),
                                Text('Incoming Call from',
                                    style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.normal))),
                                SizedBox(height: 20.h),
                                Text(incomingCallNo,
                                    style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            fontSize: 25.sp,
                                            fontWeight: FontWeight.w800))),
                                Spacer(),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {},
                                      child: CircleAvatar(
                                        backgroundColor: Colors.green,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 70.w,
                                    ),
                                    CircleAvatar(
                                      backgroundColor: Colors.red,
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 45.h,
                                )
                              ],
                            ))),
                  )
                : Visibility(visible: false, child: Container())
          ]),
        ),
        bottomNavigationBar: MyBottomNavigationBar(
          onItemTapped: _onItemTapped,
          selectedIndex: selectedIndex,
        ));
  }
}

class CopyTextButton extends StatelessWidget {
  final String textToCopy = callLink;

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
      icon: Icon(Icons.content_copy,size: 20,),
    );
  }
}
