import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:scrollx/screens/Overlay%20screens/image.dart';
import 'package:scrollx/screens/Overlay%20screens/text.dart';
import 'package:scrollx/screens/Overlay%20screens/textimage.dart';
import 'package:scrollx/screens/Overlay%20screens/video.dart';
import 'package:scrollx/screens/Overlay%20screens/videotext.dart';
import 'package:scrollx/screens/addedremindersinhome/textaudioreminder.dart';
import 'package:scrollx/screens/database/sqflite.dart';

import '../formsdesign.dart';
class homescreen extends StatefulWidget {

  homescreen({Key? key,}) : super(key: key);

  @override
  State<homescreen> createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {




  int _selectedIndex = 0;

  List<List<String>> _lists = [    [],
    [],
    [],
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _addItemToList(String item) {
    setState(() {
      _lists[_selectedIndex].add(item);
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigoAccent.shade400,
/*
      floatingActionButton:InkWell(
        onTap: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (_)=>formspages(


          )));
        },
        child: Container(
          width:150,
          height: 55,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: LinearGradient(

                begin: Alignment.topLeft,

                end: Alignment.bottomRight,

                colors: [

                  Colors.red,

                  Colors.yellowAccent,

                  Colors.red

                ]

            ),

          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add,color: Colors.white,),
              Text('Add Reminder',style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.bold),)
            ],
          ),
        ),
      ),*/


      body: Padding(
        padding: const EdgeInsets.only(),
        child: SingleChildScrollView(
          child: Stack(
            children:[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*
                Text('ScrollX',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 23
                ),),
                SizedBox(height: 15,),

                Container(
                  height: 164,
                  width: 400,
                  padding: EdgeInsets.all(13),
                  decoration: BoxDecoration(
                    // color: Colors.indigo,
image: DecorationImage(
  image: AssetImage('images/x.png'),fit: BoxFit.cover
),
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
                      borderRadius:BorderRadius.circular(15)
                  ),

                ),
                SizedBox(height: 15,),
                /*
                Row(

                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.of(context).push(
                            CupertinoPageRoute(
                                fullscreenDialog: true,
                                builder: (_)=>textaudioreminder())

                        );
                      },
                      child: Container(
                        width: 80,
                        height: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          gradient: LinearGradient(

                              begin: Alignment.topLeft,

                              end: Alignment.bottomRight,

                              colors: [

                                Colors.red,

                                Colors.pinkAccent,

                                Colors.red

                              ]

                          ),

                        ),
                        child: Text('Text ',style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),
                      ),
                    ),


                    SizedBox(width: 14,),
                    InkWell(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (_)=>formspages(


                        )));
                      },
                      child: Container(
                        width: 120,
                        height: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          gradient: LinearGradient(

                              begin: Alignment.topLeft,

                              end: Alignment.bottomRight,

                              colors: [

                                Colors.green,

                                Colors.green.shade300,


                              ]

                          ),

                        ),
                        child: Text('Text + Image',style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),
                      ),
                    ),

                    SizedBox(width: 14,),
                    InkWell(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (_)=>formspages(


                        )));
                      },
                      child: Container(
                        width: 130,
                        height: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          gradient: LinearGradient(

                              begin: Alignment.topLeft,

                              end: Alignment.bottomRight,

                              colors: [

                                Colors.red,

                                Colors.yellowAccent,

                                Colors.red

                              ]

                          ),

                        ),
                        child: Text('Video + Text ',style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),
                      ),
                    ),




                  ],
                ),
                SizedBox(height: 10,),
Row(children: [

  InkWell(
    onTap: (){
      Navigator.of(context).push(MaterialPageRoute(builder: (_)=>formspages(


      )));
    },
    child: Container(
      width: 80,
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: LinearGradient(

                begin: Alignment.topLeft,

                end: Alignment.bottomRight,

                colors: [

                  Colors.blue,

                  Colors.indigo,

                  // Colors.red

                ]

            ),

      ),
      child: Text('Image',style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),
    ),
  ),
  SizedBox(width: 13,),
  InkWell(
    onTap: (){
      Navigator.of(context).push(MaterialPageRoute(builder: (_)=>formspages(


      )));
    },
    child: Container(
      width: 120,
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: LinearGradient(

                begin: Alignment.topLeft,

                end: Alignment.bottomRight,

                colors: [

                  Colors.indigo,

                  Colors.pinkAccent,

                  Colors.indigo

                ]

            ),

      ),
      child: Text('Video + Audio',style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),
    ),
  ),
],),*/
                Text('Timer',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 23
                ),),
                SizedBox(height: 15,),
Container(
    height: 440,
    width: 350,
    decoration: BoxDecoration(
       color: Colors.white,
borderRadius: BorderRadius.circular(30)
     // shape:BoxShape.circle
    ),

    child: Lottie.asset('images/c5.json',))
*/
                Container(
                  height: 270,
                  width: 260,
                  margin: EdgeInsets.only(left: 135),
                  decoration: BoxDecoration(
                color: Colors.indigoAccent,
              // shape: BoxShape.circle
                borderRadius: BorderRadius.only(topLeft: Radius.circular(200),bottomLeft: Radius.circular(200))
                  ),
                ),
                Container(
                  height: 140,
                  width: 80,
                  margin: EdgeInsets.only(right: 210),
                  decoration: BoxDecoration(
                      color: Colors.indigoAccent,
                      borderRadius: BorderRadius.only(topRight: Radius.circular(200),bottomRight: Radius.circular(200))
                  ),
                ),

              ],
            ),
              Padding(
                padding: const EdgeInsets.only(top: 240),
                child: InkWell(
                    onTap: (){
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (_)=>formspages(


                      )));
                    },
                    child: Image.asset('images/aq.png',)),
              )
              ,
              InkWell(
                onTap: (){
                  setState(() {

                  });
                },
                child: Container(
                  height: 100,
                  width: 230,

                  margin: EdgeInsets.only(left: 200,top: 80),
                  decoration: BoxDecoration(


                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.white.withOpacity(0.7),
                          Colors.grey.withOpacity(0.7),
                        ],
                      ),
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(200),bottomLeft: Radius.circular(200))
                  ),
                  child: Row(
                    children: [

                      Container(
                        height: 80,
                        margin: EdgeInsets.only(left: 14),
                        decoration: BoxDecoration(
                           // color: Colors.white,
                           shape: BoxShape.circle,

                          border: Border.all(color: Colors.white,width: 5)
                        ),
                        child: Container(
                          height: 100,
                          margin: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle
                          ),
                            child: Image.asset('images/xa.png',height: 10,)
                        ),
                      ),
                      SizedBox(width: 8,),
                      Text('Alert Mode',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16
                      ),),
                    ],
                  ),
                ),
              ),
            ]
          ),
        ),
      ),

    );
  }
}
