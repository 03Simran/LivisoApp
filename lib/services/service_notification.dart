
import 'dart:io';
import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:liviso_flutter/utils/incoming_call.dart';

class NotificationServices {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  void requestNotificationsPermission() async {
   
   NotificationSettings settings = await messaging.requestPermission(
    alert : true,
    announcement: true,
    badge: true,
    carPlay : true,
    criticalAlert : true,
    provisional: true,
    sound : true
   );

   if(settings.authorizationStatus == AuthorizationStatus.authorized){
    print("User granted permission");
   } else if (settings.authorizationStatus == AuthorizationStatus.provisional){
    print("User granted provisonal permissions");
   }else{
     print("user denied permissions");
   }

  }


  
  void initLocalNotifications(BuildContext context, RemoteMessage message) async{
   var androidInitializationSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
      var iosInitializationSettings = DarwinInitializationSettings();
     
      var initializationSettings = InitializationSettings(
        android: androidInitializationSettings,
        iOS: iosInitializationSettings
      );

      await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onDidReceiveNotificationResponse: (payload) {
        handleMessage(context, message);
      },
      );
  }
  
  void fireBaseInit(BuildContext context){
    FirebaseMessaging.onMessage.listen((message) {

      if (kDebugMode) {
        print(message.notification!.title.toString());
         print(message.notification!.body.toString());
         print(message.data.toString());
         print(message.data["type"]);
         print(message.data["phoneNo"]);
      }
     
      showNotification(message);

      if (Platform.isAndroid) {
         initLocalNotifications(context, message);
        showNotification(message);
        }
        else{
          showNotification(message);
        }
    });
       
  }

  Future<void>  showNotification(RemoteMessage message) async {

     AndroidNotificationChannel channel = AndroidNotificationChannel(
      Random.secure().nextInt(100000).toString(), 
      "High Importance Channel",
      importance: Importance.max
      );

      

     AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      channel.id.toString(), 
      channel.name.toString(),
      channelDescription: "your channel description",
      importance: Importance.high,
      priority: Priority.high,
      ticker: 'ticker');


      DarwinNotificationDetails darwinNotificationDetails = DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      );

      NotificationDetails notificationDetails= NotificationDetails(
        android: androidNotificationDetails,
        iOS: darwinNotificationDetails
      );

     Future.delayed(Duration.zero, (){
   _flutterLocalNotificationsPlugin.show(
      0,
       message.notification!.title.toString(), 
       message.notification!.body.toString(), 
       notificationDetails);
      

     }
     );
     
  }



  Future<String?> getDeviceToken() async {
    String? token = await messaging.getToken();
    return token;
  }

  void isTokenRefresh(){
    messaging.onTokenRefresh.listen ((event){
      event.toString();
      print("refreshToken");
    });
  }
 
  Future<void> setUpInteractMessage(BuildContext context) async {
   RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();

   if(initialMessage!=null){
    handleMessage(context, initialMessage);
   }

   FirebaseMessaging.onMessageOpenedApp.listen((event){
     handleMessage(context, event);
   });
  }
  
  void handleMessage(BuildContext context, RemoteMessage message){
     if(message.data["type"]== 'incomingCall'){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>IncomingCallNotification(incomingCall: message.data["phoneNo"], roomName: message.data["roomId"])));
     }
  }
}