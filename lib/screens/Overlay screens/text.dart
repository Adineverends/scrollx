

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:lottie/lottie.dart';
class textoverlay extends StatefulWidget {

  final String remindertext;
  final String reminderimage;
  final String reminderudio;

  const textoverlay({Key? key
  ,required this.remindertext,
    required this.reminderudio,
    required this.reminderimage

  }) : super(key: key);

  @override
  State<textoverlay> createState() => _textoverlayState();
}

class _textoverlayState extends State<textoverlay> {

  /*

  List<DocumentSnapshot> _recentDocuments = [];

  @override
  void initState() {
    super.initState();
    _loadRecentDocuments();
  }

  // Retrieve the most recent documents in a collection
  Future<void> _loadRecentDocuments() async {
    List<DocumentSnapshot> recentDocuments = await getRecentDocuments("mgreminders", 1);
    setState(() {
      _recentDocuments = recentDocuments;
    });
  }

  Future<List<DocumentSnapshot>> getRecentDocuments(String collectionName, int limit) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(collectionName)
        .orderBy("timestamp", descending: true)
        .limit(limit)
        .get();
    return querySnapshot.docs;
  }
*/


  @override
  Widget build(BuildContext context) {

    /*
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ClipRRect(
       borderRadius: BorderRadius.circular(15),
        child: Scaffold(
          body: Column(
            children: [
              TextButton(
                onPressed: () {
                  FlutterOverlayWindow.closeOverlay();
                },
                child: const Text("Close Overlay"),
              ),

              Expanded(
                child: ListView.builder(
                     itemCount: _recentDocuments.length,
                     itemBuilder: (BuildContext context, int index) {
                Map<String, dynamic> data = _recentDocuments[index].data() as Map<String, dynamic>;
                return       Container(
                  // height: 300,
                  margin: EdgeInsets.only(top: 15),
                  decoration: BoxDecoration(
                    //     color: Colors.redAccent,
                    //borderRadius: BorderRadius.circular(25)
                  ),
                  child: Expanded(
                    child: Column(

                      children: [

                        // FEATURED IMAGE
                        /*
                            data['netwokimage'] == null? Container():
                            Container(
                              // height: 714,
                              width: 400,
                              padding: EdgeInsets.all(13),
                              decoration: BoxDecoration(
                                // color: Colors.indigo,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15),


                                ),

                                color: Colors.white,
                                /*
                              image: DecorationImage(
                                image: NetworkImage(
                                  data['imagefile']
                                ),
                                fit: BoxFit.cover
                              )*/
                                //  border: Border.all(color: Colors.redAccent,)
                                // borderRadius: BorderRadius.circular(20),

                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.network(

                                    data['netwokimage']


                                ),
                              ),

                            ),

                             */
                        data['imagefile'] == null? Container():
                        Container(
                         // height: 454,
                          width: 400,
                         // margin: EdgeInsets.all(30),
                          padding: EdgeInsets.all(13),
                          decoration: BoxDecoration(
                            // color: Colors.indigo,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),


                            ),

                            color: Colors.white,
                            /*
                              image: DecorationImage(
                                image: NetworkImage(
                                  data['imagefile']
                                ),
                                fit: BoxFit.cover
                              )*/
                            //  border: Border.all(color: Colors.redAccent,)
                            // borderRadius: BorderRadius.circular(20),

                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.file(
                                File(
                                    data['imagefile'])


                            ),
                          ),

                        ),

                        // SizedBox(height: 20,),
                        //  data['ReminderText'] == ''? Container():
                        Container(
                          // height: 114,
                          width: 400,
                          padding: EdgeInsets.all(13),
                          decoration: BoxDecoration(
                            // color: Colors.indigo,
                            // borderRadius: BorderRadius.circular(8),

                            color: Colors.indigoAccent.shade400,
                            //  border: Border.all(color: Colors.redAccent,)
                            // borderRadius: BorderRadius.circular(20),

                          ),
                          child: Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(data['ReminderText'],style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold
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
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15),


                            ),
                            // borderRadius: BorderRadius.circular(10)
                          ),
                          child: Row(
                              children: [
                                Lottie.asset('images/sound.json',),
                                Lottie.asset('images/sound.json',),
                              ]
                          ),
                        ),

                      ],


                    ),
                  ),

                );
                     },
                 ),
              ),
            ],
          ),
        ),
      ),
    );*/

    /*
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.indigo.shade900,
              Colors.indigoAccent.shade200,

            ]
        ),
      ),
      child: Scaffold(
    backgroundColor: Colors.transparent,



        body: Stack(

          children:[

          Padding(
            padding: const EdgeInsets.only(top: 60,left: 20,right: 20),
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('mgreminders').orderBy('timestamp',descending: true).limit(1).snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }

                return GridView.count(
                  crossAxisCount: 1,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                  childAspectRatio:0.6,
                  children: snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                    return     Container(

                      child: Column(
                        children: [

                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(17,),topRight: Radius.circular(17))
                    ),

                      child: Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(13.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(13),

                              child: Image.network(data['imagefile'])),
                        ),
                      )),
                          Container(
                          //  height: 114,
                            width: 400,
                            padding: EdgeInsets.all(13),
                            decoration: BoxDecoration(
                               color: Colors.indigoAccent,

                            //  color: Colors.indigoAccent.shade400,
                              //  border: Border.all(color: Colors.redAccent,)
                              // borderRadius: BorderRadius.circular(20),

                            ),
                            child: Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(data['ReminderText'],style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold
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
                    );

                  }).toList(),
                );
              },
            ),
          ),
            IconButton(onPressed: (){
              FlutterOverlayWindow.closeOverlay();
            },
                icon: Icon(Icons.cancel,color: Colors.white,)

            )

          ]
        ),





      ),
    );*/

    return Scaffold(
      backgroundColor: Colors.indigo,



      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('mgreminders').orderBy('timestamp',descending: true).limit(1).snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }

            return GridView.count(
              crossAxisCount: 1,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              childAspectRatio:0.6,
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   ClipRRect(
                     borderRadius: BorderRadius.circular(13),
                     child: Image.network(data['imagefile']),
                   ),
                    SizedBox(height: 10,),
                    Text(data['ReminderText'],style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),),

                    SizedBox(height: 10,),

                    InkWell(
                      onTap: (){
                        FlutterOverlayWindow.closeOverlay();
                      },
                      child: Container(
                        //color: Colors.black,
                          width: 500,
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(13),
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Text('close reminder',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),)),
                    ),


                  ],
                );
              }).toList(),
            );
          },
        ),
      ),





    );


    

  }
}
