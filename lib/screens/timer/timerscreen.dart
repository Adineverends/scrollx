import 'dart:async';
import 'dart:developer';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:scrollx/screens/home.dart';

import '../Overlay screens/text.dart';

class timerscreen extends StatefulWidget {
  final int totalSeconds;


   timerscreen({Key? key,required this.totalSeconds,


   }) : super(key: key);

  @override
  State<timerscreen> createState() => _timerscreenState();
}

class _timerscreenState extends State<timerscreen> {



  int? _secondsRemaining;
  Timer? _timer;
  bool _paused = false;
  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _secondsRemaining = widget.totalSeconds;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (!_paused) {
        setState(() {
          if (_secondsRemaining! > 0) {
            _secondsRemaining = _secondsRemaining! - 1;
          } else {
            _timer?.cancel();

            _showMessage();
            Navigator.of(context).push(
                CupertinoPageRoute(
                    fullscreenDialog: true,
                    builder: (_)=>home()

                ));
          }
        });
      }
    });
  }

  void _showMessage() async {

    if (await FlutterOverlayWindow.isActive()) return;

    await FlutterOverlayWindow.showOverlay(
    enableDrag: false,
    overlayTitle: "Scrollx",
    overlayContent: 'Overlay Enabled',
    flag: OverlayFlag.defaultFlag,
    alignment: OverlayAlignment.center,
    visibility: NotificationVisibility.visibilityPrivate,
 //   positionGravity: PositionGravity.auto,
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  IconData _getPauseIcon() {
    return _paused ? Icons.play_arrow : Icons.pause;
  }

  String _getPauseTooltip() {
    return _paused ? 'Resume' : 'Pause';
  }

  void _togglePause() {
    setState(() {
      _paused = !_paused;
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.indigoAccent.shade400,
          body: Stack(
            children: [
              Container(
                height: 290,
                width: 220,
                margin: EdgeInsets.only(left: 175),
                decoration: BoxDecoration(
                    color: Colors.indigoAccent.withOpacity(0.8),
                    // shape: BoxShape.circle
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(200),bottomLeft: Radius.circular(220))
                ),
              ),

              Container(
                height: 110,
                width: 70,
                margin: EdgeInsets.only(right: 210,top: 250),
                decoration: BoxDecoration(
                    color: Colors.indigoAccent.withOpacity(0.8),
                    borderRadius: BorderRadius.only(topRight: Radius.circular(200),bottomRight: Radius.circular(200))
                ),
              ),
              Column(
                children: [


                  Container(
                    height: 330
                    ,
          margin: EdgeInsets.only(top: 60,left: 20,right: 20),
                    padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
                      shape: BoxShape.circle,
                   color: Colors.indigoAccent.withOpacity(0.5)
                    ),
                    child: Stack(

                        children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 130,left: 100),
                          child: Column(
                            children: [
                              _secondsRemaining == null
                                  ? Container()
                                  : Text(
                                '${_secondsRemaining! ~/ 60}m ${_secondsRemaining! % 60}s',
                                style: TextStyle(fontSize: 36,color: Colors.white),
                              ),
                            //  SizedBox(height: 5,),
                              Text('Remaning',style: TextStyle(color: Colors.white,letterSpacing: 1),)
                            ],
                          ),
                        ),

                          Image.asset('images/nk.png',),

                        ]

                    ),
                  ),
                  SizedBox(height: 40,),
                  Container(
                    height: 60,
                    width: 300,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(31),
                        color: Colors.orange.shade400
                    ),
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('images/croc.png',height: 50,),
                        SizedBox(width: 16,),
                        Text('Pause the Timer',style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w500,letterSpacing: 1),),
                      SizedBox(width: 51,),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle
                          ),
                          child: IconButton(
                            onPressed: _togglePause,
                            icon: Icon(_getPauseIcon(),color: Colors.indigoAccent,),
                            tooltip: _getPauseTooltip(),
                          ),
                        ),

                      ],
                    ),
                  ),
                  SizedBox(height: 48,),

                  Text("You're in Reminder session now,go back to screen \n             we will notify you when timer ends.",style: TextStyle(color: Colors.white,fontSize: 13,letterSpacing: 0),),

              ],
              ),


            ],
          ),
          bottomNavigationBar:  Container(
            height: 110,
           // margin: EdgeInsets.only(top: 1),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30))
            ),
            child: Column(
            //  mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 30,),
                Padding(
                  padding: const EdgeInsets.only(left: 9),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('I am Giving up',style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w500,letterSpacing: 0),),
                      SizedBox(width: 5,),
                      Image.asset('images/sad.png',height: 25,)
                    ],
                  ),
                ),
                SizedBox(height: 15,),
                InkWell(
                    onTap: (){
                      setState(() {

                        Navigator.of(context).push(
                            CupertinoPageRoute(
                                fullscreenDialog: true,
                                builder: (_)=>home()

                            ));

                      });
                    },
                    child: Text('Tap to end the session',style: TextStyle(color: Colors.black,fontSize: 13,letterSpacing: 1),)),
              ],
            ),
          ),

    ));
  }
}

