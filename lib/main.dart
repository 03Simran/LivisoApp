
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:liviso_flutter/screens/home_scrn.dart';
import 'package:liviso_flutter/screens/splash.dart';
import 'package:liviso_flutter/utils/colors.dart';
import 'package:provider/provider.dart';
// import 'package:liviso_flutter/screens/login.dart';
// import 'package:liviso_flutter/services/notif_service.dart';


// import 'package:liviso_flutter/screens/homeScrn.dart';
// import 'package:liviso_flutter/screens/addprofile.dart';
// import 'package:liviso_flutter/screens/login.dart';
// import 'package:liviso_flutter/screens/profileScrn.dart';

// import 'package:liviso_flutter/utils/incoming_call.dart';
// import 'package:liviso_flutter/screens/signup.dart';
// import 'package:liviso_flutter/services/socketConnection.dart';
// import 'package:liviso_flutter/screens/WebrtcDemoJoin.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_fireBaseMessagingbackgroundHandler);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<UserIdProvider>(create: (_) => UserIdProvider()),
        //ChangeNotifierProvider<CallHistoryProvider>(create: (_) => CallHistoryProvider()),
      ],
      child: const MyApp(),
    ),
  );
}


@pragma('vm:entry--point')
Future<void> _fireBaseMessagingbackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  if (kDebugMode) {
    print(message.notification!.title.toString());
  }   
}

final ThemeData themeData = ThemeData(
   primaryColor: ThemeColors.primaryColor,
   
   fontFamily: GoogleFonts.poppins().fontFamily,
   textTheme: TextTheme(
    bodyMedium: GoogleFonts.poppins(),
   )
);

class MyApp extends StatelessWidget {
  
 const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  ScreenUtilInit(
        designSize:const Size(360,800),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return  MaterialApp(
            theme: themeData,
            navigatorKey: HomeScreen1.navigatorKey,  
             debugShowCheckedModeBanner: false,
             home : const SplashScreen(),
          );
        }, );
    
  }
}

class UserIdProvider extends ChangeNotifier {
  String userId = "default_user_id";
}

