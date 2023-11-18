import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

import 'package:scrollx/screens/home.dart';
import 'package:scrollx/overlays/scrollx/screens/videolist.dart';
import 'package:scrollx/screens/forms/imageaudioform.dart';
import 'package:scrollx/screens/forms/imagetextaudioform.dart';
import 'package:scrollx/screens/forms/textaudioform.dart';
import 'package:scrollx/screens/forms/videoform.dart';
import 'package:scrollx/screens/forms/videotextaudioform.dart';

class formspages extends StatefulWidget {

  const formspages({Key? key,


  }) : super(key: key);

  @override
  State<formspages> createState() => _formspagesState();
}

class _formspagesState extends State<formspages> {










  @override
  Widget build(BuildContext context) {
     return SafeArea(
       child: Scaffold(
         backgroundColor: Colors.grey.shade200,
         body: Column(
          children: [

            Container(
              height: 50,
              width: double.infinity,
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 10,top: 10),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                // borderRadius: BorderRadius.only(topLeft: Radius.circular(20))
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Reminder Styles',style: TextStyle(color: Colors.black,
                      fontWeight: FontWeight.bold,fontSize: 29
                  ),),
                  SizedBox(height: 3,),
                  Container(
                    height: 5,
                    width: 50,
                    decoration: BoxDecoration(
                        color: Colors.indigoAccent.shade400,
                        borderRadius: BorderRadius.circular(20)
                    ),
                  )
                ],
              ),
            ),

            Container(
              height: 700,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 5,left: 15,right: 15),
                  child: Column(
                    //  crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: (){

                          setState(() {

                            /*
                      showModalBottomSheet(context: context,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
                          ),
                          builder: (context){
                            return textaudioform();
                          }

                      );*/
                        
                            Navigator.of(context).push(
                                CupertinoPageRoute(
                                    fullscreenDialog: true,
                                    builder: (_)=>textaudioform(featuredfilepath: '',featuredimagepath: '',))

                            );
                          });
                        },
                        child: Column(
                          children: [
                            Container(
                              height: 114,
                              width: 400,
                              padding: EdgeInsets.all(13),
                              decoration: BoxDecoration(
                                 color: Colors.indigoAccent.shade400,


                                  //  border: Border.all(color: Colors.redAccent,)
                                  // borderRadius: BorderRadius.circular(20),
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(17),
                                      topLeft: Radius.circular(17)
                                  )
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Stop Scrolling you  \nhave your exam',style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold
                                  ),
                                  ),
                                  //  Divider(),

                                  //ALIGN
                                  /*
                            Padding(
                              padding: const EdgeInsets.only(top: 17,left: 40),
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: IconButton(
                                  icon: Icon(Icons.cancel,color: Colors.white,),
                                  onPressed: (){},

                                ),
                              ),
                            ),*/



                                ],
                              ),
                            ),
                            Container(
                              height: 50,
                              width: 400,
                              decoration: BoxDecoration(
                                  color: Colors.white,
/*
                              gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Colors.red,
                                    Colors.yellowAccent,
                                    Colors.red
                                  ]
                              ),
                              */

                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(17),
                                      bottomLeft: Radius.circular(17)
                                  )
                              ),
                              child: Row(
                                children: [
                                  Lottie.asset('images/sound.json',),
                                  Lottie.asset('images/sound.json',),
                                  SizedBox(width: 30,),
                                  Image.asset('images/adds.png',)
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                      SizedBox(height: 20,),
                      InkWell(
                        onTap: (){
                          setState(() {
                            Navigator.of(context).push(
                                CupertinoPageRoute(
                                    fullscreenDialog: true,
                                    builder: (_)=>imagetextaudioform())

                            );
                          });
                        },
                        child: Column(
                          children: [

                            Container(
                              height: 264,
                              width: 400,
                              padding: EdgeInsets.all(13),
                              decoration: const BoxDecoration(
                                // color: Colors.indigo,

                           //      color: Colors.indigoAccent.shade400,
                                  //  border: Border.all(color: Colors.redAccent,)
                                  // borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                      image: AssetImage('images/qut.jpg'),
                                      fit: BoxFit.cover
                                  ),
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(17),
                                      topLeft: Radius.circular(17)
                                  )
                              ),

                            ),
                            Container(
                              height: 114,
                              width: 400,
                              padding: EdgeInsets.all(13),
                              decoration: BoxDecoration(
                                // color: Colors.indigo,

                                color: Colors.indigoAccent.shade400,
                                //  border: Border.all(color: Colors.redAccent,)
                                // borderRadius: BorderRadius.circular(20),

                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Stop Scrolling you  \nhave your exam',style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold
                                  ),
                                  ),
                                  //
                                  //  Divider(),
                                  /*
                            Padding(
                              padding: const EdgeInsets.only(top: 17,left: 40),
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: IconButton(
                                  icon: Icon(Icons.cancel,color: Colors.white,),
                                  onPressed: (){},

                                ),
                              ),
                            ),
*/


                                ],
                              ),
                            ),
                            Container(
                              height: 50,
                              width: 400,
                              decoration: BoxDecoration(
                                  color: Colors.white,
/*
                              gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Colors.red,
                                    Colors.yellowAccent,
                                    Colors.red
                                  ]
                              ),
                              */

                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(17),
                                      bottomLeft: Radius.circular(17)
                                  )
                              ),
                              child: Row(
                                children: [
                                  Lottie.asset('images/sound.json',),
                                  Lottie.asset('images/sound.json',),
                                  SizedBox(width: 30,),
                                  Image.asset('images/adds.png',)
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                      SizedBox(height: 20,),
                      InkWell(
                        onTap: (){
                          setState(() {
                            Navigator.of(context).push(
                                CupertinoPageRoute(
                                    fullscreenDialog: true,
                                    builder: (_)=>imageaudioform())

                            );
                          });
                        },
                        child: Column(
                          children: [

                            Container(
                              height: 284,
                              width: 400,
                              padding: EdgeInsets.all(13),
                              decoration: BoxDecoration(
                                // color: Colors.indigo,

                                  gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Colors.red,
                                        Colors.yellowAccent,
                                        Colors.red
                                      ]
                                  ),
                                  //  border: Border.all(color: Colors.redAccent,)
                                  // borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                      image: AssetImage('images/qut.jpg'),
                                      fit: BoxFit.cover
                                  ),
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(17),
                                      topLeft: Radius.circular(17)
                                  )
                              ),

                            ),

                            Container(
                              height: 50,
                              width: 400,
                              decoration: BoxDecoration(
                                  color: Colors.white,
/*
                              gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Colors.red,
                                    Colors.yellowAccent,
                                    Colors.red
                                  ]
                              ),
                              */

                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(17),
                                      bottomLeft: Radius.circular(17)
                                  )
                              ),
                              child: Row(
                                children: [
                                  Lottie.asset('images/sound.json',),
                                  Lottie.asset('images/sound.json',),
                                  SizedBox(width: 30,),
                                  Image.asset('images/adds.png',)
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                      SizedBox(height: 20,),
                      InkWell(
                        onTap: (){
                          setState(() {
                            Navigator.of(context).push(
                                CupertinoPageRoute(
                                    fullscreenDialog: true,
                                    builder: (_)=>videotextaudioform())

                            );
                          });
                        },
                        child: Column(
                          children: [

                            Container(
                              height: 264,
                              width: 400,
                              padding: EdgeInsets.all(13),
                              decoration: BoxDecoration(
                                // color: Colors.indigo,

                                  gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Colors.red,
                                        Colors.yellowAccent,
                                        Colors.red
                                      ]
                                  ),
                                  //  border: Border.all(color: Colors.redAccent,)
                                  // borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                      image: AssetImage('images/qut.jpg'),
                                      fit: BoxFit.cover
                                  ),
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(17),
                                      topLeft: Radius.circular(17)
                                  )
                              ),

                            ),
                            Container(
                              height: 114,
                              width: 400,
                              padding: EdgeInsets.all(13),
                              decoration: BoxDecoration(
                                // color: Colors.indigo,

                                color: Colors.indigoAccent.shade400,
                                //  border: Border.all(color: Colors.redAccent,)
                                // borderRadius: BorderRadius.circular(20),

                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Stop Scrolling you  \nhave your exam',style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold
                                  ),
                                  ),
                                  //
                                  //  Divider(),
                                  /*
                            Padding(
                              padding: const EdgeInsets.only(top: 17,left: 40),
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: IconButton(
                                  icon: Icon(Icons.cancel,color: Colors.white,),
                                  onPressed: (){},

                                ),
                              ),
                            ),
*/


                                ],
                              ),
                            ),
                            Container(
                              height: 50,
                              width: 400,
                              decoration: BoxDecoration(
                                  color: Colors.white,
/*
                              gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Colors.red,
                                    Colors.yellowAccent,
                                    Colors.red
                                  ]
                              ),
                              */

                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(17),
                                      bottomLeft: Radius.circular(17)
                                  )
                              ),
                              child: Row(
                                children: [
                                  Lottie.asset('images/sound.json',),
                                  Lottie.asset('images/sound.json',),
                                  SizedBox(width: 30,),
                                  Image.asset('images/adds.png',)
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                      SizedBox(height: 20,),
                      InkWell(
                        onTap: (){
                          showModalBottomSheet(context: context,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
                              ),
                              builder: (context){
                                return videoaudioform();
                              }

                          );
                        },
                        child: Column(
                          children: [

                            Container(
                              height: 284,
                              width: 400,
                              padding: EdgeInsets.all(13),
                              decoration: BoxDecoration(
                                // color: Colors.indigo,

                                  gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Colors.red,
                                        Colors.yellowAccent,
                                        Colors.red
                                      ]
                                  ),
                                  //  border: Border.all(color: Colors.redAccent,)
                                  // borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                      image: AssetImage('images/qut.jpg'),
                                      fit: BoxFit.cover
                                  ),
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(17),
                                      topLeft: Radius.circular(17)
                                  )
                              ),

                            ),

                            Container(
                              height: 50,
                              width: 400,
                              decoration: BoxDecoration(
                                  color: Colors.white,
/*
                              gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Colors.red,
                                    Colors.yellowAccent,
                                    Colors.red
                                  ]
                              ),
                              */

                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(17),
                                      bottomLeft: Radius.circular(17)
                                  )
                              ),
                              child: Row(
                                children: [
                                  Lottie.asset('images/sound.json',),
                                  Lottie.asset('images/sound.json',),
                                  SizedBox(width: 30,),
                                  Image.asset('images/adds.png',)
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),











                      SizedBox(height: 20,),
                    ],
                  ),
                ),
              ),
            ),
            
          //  Image.file(File['/data/user/0/com.example.scrollx/cache/file_picker/IMG_20230405_175824.jpg'])
          ],
    ),
       ),
     );

     
  }
}

