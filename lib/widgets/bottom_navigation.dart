import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liviso_flutter/utils/colors.dart';

class MyBottomNavigationBar extends StatefulWidget {
  final int selectedIndex;
  final void Function(int) onItemTapped;

  MyBottomNavigationBar({
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedLabelStyle : GoogleFonts.poppins(),
         
        unselectedLabelStyle: GoogleFonts.poppins(),
        selectedItemColor: ThemeColors.primaryColor,
        unselectedItemColor: ThemeColors.textColor7,
        elevation: 5,
        currentIndex: widget.selectedIndex,
        onTap: widget.onItemTapped,
        
        items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home, 
         ),
          label: 'Home',
          
        ),

        BottomNavigationBarItem(
          icon: Icon(Icons.video_call,
          ),
          label: 'Video',
        ),

        BottomNavigationBarItem(
          icon: Icon(Icons.person,
         ),
          label: 'Profile',
        ),

      ]);
  }
}
