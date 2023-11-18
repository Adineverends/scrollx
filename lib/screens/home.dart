import 'dart:io';

import 'package:flutter/material.dart';
import 'package:scrollx/main.dart';
import 'package:scrollx/overlays/scrollx/screens/addreminder.dart';
import 'package:scrollx/overlays/scrollx/screens/reminder%20page.dart';
import 'package:scrollx/screens/ADMIN%20PANEL.dart';
import 'package:scrollx/screens/formsdesign.dart';
import 'package:scrollx/screens/navitems/account.dart';
import 'package:scrollx/screens/navitems/homepage.dart';
import 'package:scrollx/screens/navitems/reminders.dart';

import 'Overlay screens/text.dart';
import 'featureditems/image.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {




  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> _widgetOptions = <Widget>[homescreen(),reminders(),account()      ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey.shade200,


      body:_widgetOptions.elementAt(_selectedIndex),


           bottomNavigationBar: BottomNavigationBar(
elevation: 0,
             items: [
               BottomNavigationBarItem(
                 icon:Icon(Icons.home)
                 /*
                 IconTheme(
                   data: IconThemeData(
                     color: Colors.white, // Set default color
                     size: 24.0,
                   ),
                   child: ShaderMask(
                     shaderCallback: (Rect bounds) {
                       return LinearGradient(
                         colors: [Colors.blue, Colors.purple],
                         begin: Alignment.topLeft,
                         end: Alignment.bottomRight,
                       ).createShader(bounds);
                     },
                     child: Icon(Icons.home),
                   ),
                 ),*/
                , label: 'Home',
               ),
               BottomNavigationBarItem(
                 icon: Icon(Icons.style_sharp)
                     /*
                 IconTheme(
                   data: IconThemeData(
                     color: Colors.white, // Set default color
                     size: 24.0,
                   ),
                   child: ShaderMask(
                     shaderCallback: (Rect bounds) {
                       return LinearGradient(
                         colors: [Colors.pink, Colors.orange],
                         begin: Alignment.topLeft,
                         end: Alignment.bottomRight,
                       ).createShader(bounds);
                     },
                     child: Icon(Icons.style_sharp),
                   ),
                 ),*/,
                 label: 'Reminders',
               ),
               BottomNavigationBarItem(
                 icon: Icon(Icons.person)
                     /*
                 IconTheme(
                   data: IconThemeData(
                     color: Colors.white, // Set default color
                     size: 24.0,
                   ),
                   child: ShaderMask(
                     shaderCallback: (Rect bounds) {
                       return LinearGradient(
                         colors: [Colors.green, Colors.yellow],
                         begin: Alignment.topLeft,
                         end: Alignment.bottomRight,
                       ).createShader(bounds);
                     },
                     child: Icon(Icons.person),
                   ),
                 ),*/,
                 label: 'Profile',
               ),
             ],
             currentIndex: _selectedIndex,
             selectedItemColor: Colors.indigoAccent.shade400,
             onTap: _onItemTapped,
            backgroundColor: Colors.white,
           )
    ,

          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.white,
            onPressed: (){
              /*
Navigator.of(context).push(MaterialPageRoute(builder: (_)=>textoverlay(
  reminderimage: '',
  reminderudio: '',
  remindertext: '',
)));*/

              Navigator.of(context).push(MaterialPageRoute(builder: (_)=>ReelsApp()));
            },
            child: Icon(Icons.add,color: Colors.indigoAccent,),
          ),

    )

    );
  }
}
