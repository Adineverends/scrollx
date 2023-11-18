
import 'package:flutter/material.dart';
import 'package:scrollx/overlays/scrollx/screens/addreminder.dart';
import 'package:scrollx/screens/featureditems/music.dart';
import 'package:scrollx/overlays/scrollx/screens/music/mymusic.dart';
import 'package:scrollx/overlays/scrollx/screens/music/voicenote.dart';

class music extends StatefulWidget {
  const music({Key? key}) : super(key: key);

  @override
  State<music> createState() => _musicState();
}

class _musicState extends State<music> {





  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('Music',style: TextStyle(color: Colors.white),),
bottom: TabBar(
    dividerColor: Colors.redAccent,
   // labelColor: Colors.redAccent,
    indicatorColor: Colors.redAccent,
    tabs: [
  Tab(
     text: 'FEATURED',


  ),
  Tab(text: 'MY MUSIC'),

]),
        ),
        body: TabBarView(
          children: [
           featuredmusicListPage(),
            musicorvoice(),

          ],
        ),
      ),
    );
  }
}



