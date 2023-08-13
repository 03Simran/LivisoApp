import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:liviso_flutter/assets/colors.dart';


class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({super.key});

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title : Text('Live Call')
      ),

      body :  Container(
        color:ThemeColors.backgroundColor,
        width: double.infinity,
        padding: EdgeInsets.all(13.w),
        child: Column(
            
          children: [
               Container(color: Colors.red,
               height:290.h,
               width:330.w,
               child : Icon(Icons.home),
               ),
               Container(color: Colors.blue,
               height:290.h,
               width:330.w,
               child : Icon(Icons.home)
              
               )
          
            ],),
      ),
        
      
      bottomNavigationBar: BottomNavigationBar(items:const [
           BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
        ]),
    );
  }
}