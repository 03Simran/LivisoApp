
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:liviso_flutter/screens/homeScrn.dart';
import 'package:liviso_flutter/screens/login.dart';
import 'package:liviso_flutter/services/notif_service.dart';

// import 'package:liviso_flutter/screens/homeScrn.dart';
// import 'package:liviso_flutter/screens/addprofile.dart';
// import 'package:liviso_flutter/screens/login.dart';
import 'package:liviso_flutter/screens/profileScrn.dart';
import 'package:liviso_flutter/screens/signup.dart';
import 'package:liviso_flutter/utils/incoming_call.dart';
// import 'package:liviso_flutter/screens/signup.dart';
// import 'package:liviso_flutter/services/socketConnection.dart';
// import 'package:liviso_flutter/screens/WebrtcDemoJoin.dart';



void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_fireBaseMessagingbackgroundHandler);
  runApp(
 
  MyApp(),
   
  );
}

@pragma('vm:entry--point')
Future<void> _fireBaseMessagingbackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print(message.notification!.title.toString());
}

class MyApp extends StatelessWidget {
  
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  ScreenUtilInit(
        designSize:const Size(360,800),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return  MaterialApp(
            navigatorKey: HomeScreen1.navigatorKey,  
             debugShowCheckedModeBanner: false,
             home : SignUpScreen(),
          );
        }, );
    
  }
}

