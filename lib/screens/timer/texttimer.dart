import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:scrollx/screens/home.dart';
import 'package:scrollx/screens/navitems/reminders.dart';
import 'package:scrollx/screens/timer/timerscreen.dart';

import '../Overlay screens/text.dart';
import '../database/textaudioformdatabase.dart';


class timer extends StatefulWidget {

final String remindertext;
final String reminderimage;
final String reminderudio;


   timer({Key? key,required this.remindertext,required this.reminderudio,required this.reminderimage}) : super(key: key);

  @override
  State<timer> createState() => _timerState();
}

class _timerState extends State<timer> {

  TextEditingController _textEditingController = TextEditingController();
  int _wordCount = 0;

  @override
  void dispose() {
    _textEditingController.dispose();
    _timer?.cancel();


    super.dispose();
  }


  int min = 0;
  int max = 120;



  @override
  void initState() {
    super.initState();
    log("Started listening");
    FlutterOverlayWindow.overlayListener.listen((event) {
      log("$event");
    });
  }

  int? _totalSeconds;
  int? _secondsRemaining;
  Timer? _timer;
  final _minutesController = TextEditingController();

  void _startTimer() {
    _secondsRemaining = _totalSeconds;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining! > 0) {
          _secondsRemaining = _secondsRemaining! - 1;
          ;
        } else {
          _timer?.cancel();

          _showMessage();
        }
      });
    });
  }




  void _showMessage() async {

   if (await FlutterOverlayWindow.isActive()) return;
    Navigator.of(context).push(MaterialPageRoute(builder: (_)=>textoverlay (
      remindertext: widget.remindertext,
      reminderudio: widget.reminderudio,
      reminderimage: widget.reminderimage,
    )));
    await FlutterOverlayWindow.showOverlay(
    enableDrag: true,
      overlayTitle: "Scrollx",
      overlayContent: 'Overlay Enabled',
      flag: OverlayFlag.defaultFlag,
      alignment: OverlayAlignment.center,
      visibility: NotificationVisibility.visibilityPrivate,
     // positionGravity: PositionGravity.auto,
    );
  }






  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigoAccent,
          elevation: 0,
          title: Text('Custom Timer'),
        ),
        backgroundColor: Colors.indigoAccent,
        body: Padding(
          padding: const EdgeInsets.only(top: 65,right:10 ,left: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Padding(
                  padding: const EdgeInsets.only(left: 60),
                  child: Row(
                    children: [
                      Container(
                        height: 50,
                        width: 200,
                        child: TextField(
                          controller: _textEditingController,
                          /*
                          onChanged: (String value) {
                            print('Changed');
                            int x;
                            try {
                              x = int.parse(value);
                            } catch (error) {
                              x = min;
                            }
                            if (x < min) {
                              x = min;
                            } else if (x > max) {
                              x = max;
                            }

                            _textEditingController.value = TextEditingValue(
                              text: x.toString(),
                              selection: TextSelection.fromPosition(
                                TextPosition(offset: _textEditingController.value.selection.baseOffset),
                              ),
                            );
                          },*/

                   textAlign: TextAlign.right, // Set text alignment to right
                          cursorColor: Colors.white,
                            maxLength: 3,

                          autofocus: true,
                          keyboardType: TextInputType.number,
                          //maxLines: 1,
                          style: TextStyle(fontSize: 94,color: Colors.white),
                          cursorHeight: 100,
                          decoration: InputDecoration(
                            // hintText: 'Enter text',
                            border: InputBorder.none,
counterStyle: TextStyle(color: Colors.white)
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 40,left: 10),
                        child: Text('mins',style: TextStyle(color: Colors.white),),
                      )
                    ],
                  ),
                )
                ,
                SizedBox(height: 26,),
                Opacity(
                  opacity: 0.5,
                  child: Container(
                    height: 50,
                    width: 340,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.indigo.shade500.withOpacity(0.9)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('images/al.png',color: Colors.white,height: 25,),
                        SizedBox(width: 20,),
                        Text('Maximum lock duration is 120 minutes',style: TextStyle(color: Colors.white,fontSize: 15),)
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 56,),

                Text(widget.remindertext),

                TextButton(
                  onPressed: () async {
                    final bool? res =
                    await FlutterOverlayWindow.requestPermission();
                    log("status: $res");
                  },
                  child: const Text("Request Permission"),
                ),

                InkWell(
                  onTap: (){
                    setState(() {


                    });
                  },
                  child: Container(
                    height: 50,
                    width: 340,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white
                    ),
                    child: Text('Start the Reminder',style: TextStyle(color: Colors.indigoAccent,fontSize: 16,fontWeight: FontWeight.w500,letterSpacing: 1),),
                  ),
                ),
                SizedBox(height: 26,),
                _secondsRemaining == null
                    ? Container()
                    : Text(
                  '${ _secondsRemaining ! ~/ 60} m ${ _secondsRemaining ! % 60} s',
                  style: TextStyle(fontSize: 24),
                ),
                InkWell(
                    onTap: (){
                      setState(() {
                        Navigator.of(context).push(
                            CupertinoPageRoute(
                                fullscreenDialog: true,
                                builder: (_)=>home())

                        );
                      });
                    },
                    child: Text('Dismiss',style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.w500,letterSpacing: 1),)),


              ],
            ),
          ),
        ),
      ),
    );
  }


}
