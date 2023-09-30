// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liviso_flutter/main.dart';

import 'package:liviso_flutter/screens/profileScrn.dart';
import 'package:liviso_flutter/services/service_notification.dart';
import 'package:liviso_flutter/utils/colors.dart';
import 'package:liviso_flutter/widgets/bottom_navigation.dart';
import 'package:liviso_flutter/widgets/homeWidgets.dart';
import 'package:liviso_flutter/widgets/loginWidgets.dart';
import 'package:http/http.dart' as http;
import 'package:liviso_flutter/models/profile_data.dart';
import 'package:provider/provider.dart';

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

  
  List<CallHistoryData>? callHistoryData = [];
  int selectedIndex = 0;
  
  bool isLoading = true;
  final incomingCallNo = '8252645278';
  bool isOpen = false;
  String shopName = 'abcd';
 

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
    UserIdProvider userIdProvider = context.read<UserIdProvider>();
    userIdProvider.userId = widget.id;

     notificationService.requestNotificationsPermission();
     //notificationService.isTokenRefresh();
     notificationService.fireBaseInit(context);
     notificationService.setUpInteractMessage(context);
     notificationService.getDeviceToken().then((value){
       print("Device Token Home screen");
       print(value); 
     });


    Future.delayed(Duration.zero, () async {
    // Show loading indicator while fetching profile data
    setState(() {
      isLoading = true;
    });
    }
    );
     
    // // Use Future.delayed to run your asynchronous operation
    Future.delayed(Duration.zero, () async {
     ProfileData? response = await fetchProfileData();
     setState(() {
      
       isOpen = response!.isOpen!;
       shopName = response.shopName;
    callLink = response.shopLink;
    callHistoryData = response.calls ;
     isLoading = false;
    });


     });

     

     
  }




  Future<ProfileData?> fetchProfileData() async {
    final response = await http.get(Uri.parse(
        'https://stealth-zys3.onrender.com/api/v1/auth/getProfile/${widget.id}'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return ProfileData.fromJson(data["user"]);
    } else {
      print("Profile Data not loaded for Home Screen");
      return null;
    }
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Logo(height: 60.h,width: 120.w,),
          titleSpacing: 7.w,
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
                SizedBox(width: 0), // Add spacing between text and icon

                IconButton(
                  onPressed: () async {
                    
                    try {
                      final response = await http.post(
                        Uri.parse(
                            'https://stealth-zys3.onrender.com/api/v1/auth/profile/${widget.id}'), 
                        body: {
                          'isOpen': isOpen.toString(),
                        },
                      );

                      if (response.statusCode == 200 ||response.statusCode == 201) {
                        print("Value CHANGED");
                        setState(() {
                      isOpen = !isOpen; // Toggle the value of isOpen
                    });
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
        body:  Container(
  padding: EdgeInsets.all(13.w),
  color: ThemeColors.backgroundColor,
  child: Stack(
    children: [
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
            child: isLoading ? 
            Center(
              child : CircularProgressIndicator(color: ThemeColors.primaryColor,)
            )
            : callHistoryData == [] ? Container(
                    margin: EdgeInsets.all(5.h),
                    padding: EdgeInsets.all(10.w),
                    width: double.infinity,
                    height: 160.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.r)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('No Calls Yet!!',
                          style : GoogleFonts.poppins(
                            textStyle: TextStyle (color: ThemeColors.textColor7,
                            fontSize: 14.sp))),
                        SizedBox(height: 10.h,),
                        Text('Start by sharing the shop link with the customers:',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style : GoogleFonts.poppins(
                            textStyle: TextStyle (color: ThemeColors.textColor7,
                            fontSize: 13.sp))),
                        SizedBox(height: 10.h,),
                        Row (
                          children: [
                            Text('ShopLink:',
                              style : GoogleFonts.poppins(
                                textStyle: TextStyle (color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 13.sp))),
                            SizedBox(width: 10.w,),
                            Container(
                              constraints: BoxConstraints(
                                maxWidth: 170.0, 
                              ),
                              child: Text( callLink, 
                                maxLines: 2, 
                                overflow: TextOverflow.ellipsis,
                                style : GoogleFonts.poppins(
                                  textStyle: TextStyle (color: ThemeColors.textColor7,
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w300)
                                ) 
                              ),
                            ),
                            SizedBox(width: 10.w,),
                            CopyTextButton()
                          ],
                        ),
                      ],
                    ),
                  )
                 : ListView.builder(
                     itemCount: callHistoryData?.length,
                    itemBuilder: (context, index) {
                      final call = callHistoryData?[index];
                      return Container(
                       margin: EdgeInsets.all(5.h),
                       padding: EdgeInsets.all(10.w),
                       width: double.infinity,
                       height: 65.h,
                       decoration: BoxDecoration(
                         color: Colors.white,
                         borderRadius: BorderRadius.circular(8.r),
                       ),
                        child: Row(
                          children: [
                           Icon(
                             Icons.arrow_circle_left,
                             size: 20.w,
                           ),
                           SizedBox(width: 7.w),
                           Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                           mainAxisAlignment: MainAxisAlignment.center,
                             children: [
                                Text(
                                 call!.phone,
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                      fontSize: 15.sp,
                                       fontWeight: FontWeight.w500,
                                      color: !call.isAccepted && !call.isRejected 
                                      ?  Colors.red
                                      :ThemeColors.primaryColor
                                    ),
                                   ),
                                 ),
                                
                             ],
                            ),
                            Spacer(),
                             Column(
                               crossAxisAlignment: CrossAxisAlignment.end,
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: [
                                 Text(
                                   "",
                                   style: GoogleFonts.poppins(
                                     textStyle: TextStyle(
                                       fontSize: 9.sp,
                                       fontWeight: FontWeight.w500,
                                       color: ThemeColors.textColor5,
                                     ),
                                   ),
                                 ),
                                 Text(
                                   call.date,
                                   style: GoogleFonts.poppins(
                                     textStyle: TextStyle(
                                       fontSize: 9.sp,
                                       fontWeight: FontWeight.w500,
                                     color: ThemeColors.textColor5,
                                     ),
                                   ),
                                 ),
                               ],
                           ),
                             SizedBox(width: 7.w),
                           ],
                         ),
                    );
                   },
                  ),
          ),
        ],
      ),
    ],
  ),
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
