


import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:scrollx/screens/forms/textaudioform.dart';

import '../buypremiumpage/premiumpage.dart';
import 'imagedetailedpage.dart';





class featuredimagelistpage extends StatefulWidget {
  const featuredimagelistpage({Key? key}) : super(key: key);

  @override
  State<featuredimagelistpage> createState() => _featuredimagelistpageState();
}

class _featuredimagelistpageState extends State<featuredimagelistpage> {

  List<String> _audioList = [];

  AudioPlayer _audioPlayer = AudioPlayer();


  @override
  void dispose() {
    _audioPlayer.stop();
    super.dispose();
  }
  int _currentIndex = -1;

  Future<void> _playAudio(String filePath, int index) async {
    int result = await _audioPlayer.play(filePath);
    if (result == 1) {
      setState(() {
        _currentIndex = index;
      });
    }
    _audioPlayer.onPlayerCompletion.listen((event) {
      setState(() {
        _currentIndex = -1;
      });
    });
  }

  Future<void> _pauseAudio() async {
    await _audioPlayer.pause();
    setState(() {
      _currentIndex = -1;
    });
  }

  Future<void> pauseAudio() async {
    await _audioPlayer.pause();
    setState(() {
      _currentIndex = -1;
    });
  }




  Future<List<String>> _fetchAudioList() async {
    List<String> audioList = [];
    try {
      // initialize Firebase Storage instance
      FirebaseStorage storage = FirebaseStorage.instance;

      // get audio folder reference from Firebase Storage
      Reference audioFolderRef = storage.ref().child('audio');

      // get all audio files inside the audio folder
      ListResult audioFiles = await audioFolderRef.listAll();

      // loop through all audio files and add their download URLs to audioList
      for (var audioFile in audioFiles.items) {
        String audioUrl = await audioFile.getDownloadURL();
        audioList.add(audioUrl);
      }
    } catch (e) {
      print('Error fetching audio list: $e');
    }
    return audioList;
  }









  //final SwiperController _swiperController = SwiperController();
  void detailed(String imageurl,bool isfree){
    Navigator.pushReplacement(context, CupertinoPageRoute(
        fullscreenDialog: true,
        builder: (_)=> imagedetailedpage(imageurl: imageurl,isfree: isfree,)));

  }




  void buypremium(){
    Navigator.push(context, CupertinoPageRoute(
        fullscreenDialog: true,
        builder: (_)=> buypremiumpage()));
  }

  bool _isPressed = false;

  Future<void> selectedFeaturedImage() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => textaudioform(featuredfilepath: '', featuredimagepath: '')),
    );

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.indigoAccent,
        appBar: AppBar(
          backgroundColor: Colors.indigoAccent,
          elevation: 0,
          title: Text('Featured Images'),
        ),


      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('mgreminders').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }

            return GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
             childAspectRatio:0.6,
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                return GestureDetector(
                  onTap: (){
                    setState(() {

                    });
                  },


                  onLongPress: (){
                    showDialog(context: context,
                        builder: (context){
                      return Padding(
                        padding: const EdgeInsets.all(25.0),

                      );
                        }
                    );
                  },


                  child: Container(
 //height: 500,
         //         width: 500,
                    padding: EdgeInsets.all(8),
                    alignment: Alignment.topRight,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),

                    ),
child: Text(data['imagefile']),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),





    );
  }
}
