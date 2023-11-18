
/*
import 'dart:async';
import 'dart:convert';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:http/http.dart' as http;

class Featured extends StatefulWidget {
  const Featured({Key? key}) : super(key: key);

  @override
  State<Featured> createState() => _FeaturedState();
}

class _FeaturedState extends State<Featured> {




  Future<List<String>> getAudioUrls() async {
    ListResult listResult = await FirebaseStorage.instance.ref('audio').listAll();
    List<Reference> audioRefs = listResult.items;
    List<String> audioUrls = [];
    for (var ref in audioRefs) {
      String url = await ref.getDownloadURL();
      audioUrls.add(url);
    }
    return audioUrls;
  }










  late AudioPlayer  _audioPlayer;


  StreamSubscription<Duration>? _durationSubscription;
  StreamSubscription<Duration>? _positionSubscription;
  bool _isPlaying = false;
  double _sliderValue = 0.0;
  Duration _duration = Duration();
  Duration _position = Duration();



  @override
  void dispose() {
    _audioPlayer.dispose();
    _durationSubscription?.cancel();
    _positionSubscription?.cancel();
    super.dispose();
  }

  void _initAudioPlayer() async {
    await _audioPlayer.setAsset('images/m.mp3');
    _durationSubscription = _audioPlayer.durationStream.listen((duration) {
      setState(() {
        _duration = duration!;
      });
    }) as StreamSubscription<Duration>?;
    _positionSubscription = _audioPlayer.positionStream.listen((position) {
      setState(() {
        _position = position;
        _sliderValue = position.inMilliseconds.toDouble();
      });
    }) as StreamSubscription<Duration>?;
  }

  void _playPause() {
    setState(() {
      if (_isPlaying) {
        _audioPlayer.pause();
        _isPlaying = false;
      } else {
        _audioPlayer.play();
        _isPlaying = true;
      }
    });
  }

  void _seekTo(double value) {
    _audioPlayer.seek(Duration(milliseconds: value.toInt()));
  }




  @override
  void initState() {
    // TODO: implement initState
    _audioPlayer=AudioPlayer();
    _initAudioPlayer();





    super.initState();
  }


  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
      //  controls(audioPlayer: _audioPlayer),
        ElevatedButton(
          onPressed: _playPause,
          child: Text(_isPlaying ? 'Pause' : 'Play'),
        ),
        Slider(
          value: _sliderValue,
          min: 0.0,
          max: _duration.inMilliseconds.toDouble(),
          onChanged: (newValue) {
            setState(() {
              _sliderValue = newValue;
            });
          },
          onChangeEnd: _seekTo,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _formatDuration(_position),
                style: TextStyle(fontSize: 18.0,color: Colors.white),
              ),
              Text(
                _formatDuration(_duration),
                style: TextStyle(fontSize: 18.0,color: Colors.white),
              ),
            ],
          ),
        ),



    FutureBuilder<List<String>>(
    future: getAudioUrls(),
    builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
    return CircularProgressIndicator();
    }
    if (snapshot.hasError) {
    return Text('Error: ${snapshot.error}',style: TextStyle(color: Colors.white),);
    }
    List<String> audioUrls = snapshot.data!;
    return ListView.builder(
    itemCount: audioUrls.length,
    itemBuilder: (context, index) {
    return ListTile(
    title: Text('Audio ${index + 1}',style: TextStyle(color: Colors.white)),
    subtitle: Text(audioUrls[index]),
    );
    },
    );
    },
    )


      ],
    );
  }
}

class controls extends StatelessWidget {
  final AudioPlayer audioPlayer;
  const controls({Key? key,required this.audioPlayer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PlayerState>(
        stream: audioPlayer.playerStateStream,
        builder: (context,snapshot){

          final playerState=snapshot.data;
          final processingstate=playerState?.processingState;
          final playing=playerState?.playing;
          final duration = audioPlayer.duration;
          final position = audioPlayer.position;




          if(!(playing ?? false)){
            return IconButton(
                onPressed:audioPlayer.play ,
                icon: Icon(Icons.play_circle,color: Colors.white)

            );
          } else if(processingstate != ProcessingState.completed){
            return Column(
              children: [
                IconButton(
                    onPressed: audioPlayer.pause,
                    icon: Icon(Icons.pause,color: Colors.white)

                ),

                if (processingstate != ProcessingState.idle)
                  Slider(

                    value: (position != null && duration != null)
                        ? position.inMilliseconds / duration.inMilliseconds
                        : 0.0,
                    onChanged: (double value) {
                      final newPosition = value * duration!.inMilliseconds;
                      audioPlayer.seek(Duration(milliseconds: newPosition.round()));
                    },
                  ),
              ],
            );
          }

          return const Icon(Icons.play_circle,color: Colors.white,);




        }

    );
  }
}


*/

/*
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class AudioListPage extends StatefulWidget {
  @override
  _AudioListPageState createState() => _AudioListPageState();
}

class _AudioListPageState extends State<AudioListPage> {
  List<String> _audioList = [];

  Future<void> _fetchAudio() async {
    try {
      ListResult result =
      await FirebaseStorage.instance.ref().child('audio').listAll();
      List<Reference> refs = result.items;
      List<String> downloadUrls =
      await Future.wait(refs.map((ref) => ref.getDownloadURL()).toList());
      setState(() {
        _audioList = downloadUrls;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Audio List'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: _fetchAudio,
            child: Text('Fetch Audio'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _audioList.length,
              itemBuilder: (BuildContext context, int index) {
                String downloadUrl = _audioList[index];
                return ListTile(
                  title: Text('Audio ${index + 1}'),
                  subtitle: Text(downloadUrl),
                  onTap: () => _playAudio(downloadUrl),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _playAudio(String downloadUrl) {
    // Play audio from URL
  }
}
*/



import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scrollx/screens/buypremiumpage/premiumpage.dart';
import 'package:scrollx/screens/forms/textaudioform.dart';

class FileData {
  final String name;
  final bool isFree;

  const FileData({required this.name, required this.isFree});
}


class featuredmusicListPage extends StatefulWidget {
  @override
  _featuredmusicListPageState createState() => _featuredmusicListPageState();
}

class _featuredmusicListPageState extends State<featuredmusicListPage> {
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

  CollectionReference audiolist= FirebaseFirestore.instance.collection('audiollist');

  late Stream<List<FileData>> _filesStream;
  late List<FileData> _files;

  @override
  void initState() {
    super.initState();
    _filesStream = FirebaseFirestore.instance
        .collection('audiollist')
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => FileData(
      name: doc['text'],
      isFree: doc['isFree'],
    ))
        .toList());
  }


  void buypremium(){
    Navigator.push(context, CupertinoPageRoute(
        fullscreenDialog: true,
        builder: (_)=>buypremiumpage()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigoAccent,
        appBar: AppBar(
          backgroundColor: Colors.indigoAccent,
          elevation: 0,
          title: Text('Featured Music'),
        ),
      body:  StreamBuilder(
          stream: audiolist.snapshots(),
          builder: (context,snapshot){
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }


            return ListView.builder(
              itemCount:snapshot.data!.docs.length,
              itemBuilder: (context,index){
                return

                  Container(
                    height: 70,
                    margin: EdgeInsets.only(top: 10,left: 14,right: 14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)
                    ),

                    child: ListTile(
                      onTap: (){

                        setState(() {
                          snapshot.data!.docs[index]['isfree'] ?
                          Navigator.pop(context,snapshot.data!.docs[index]['audio'] )
                              :buypremium();
                        });
                      }

                      //snapshot.data!.docs[index]['isfree'] ? addmusic:buypremium ,
                      ,

                      leading: Icon(Icons.library_music_rounded,color: Colors.orangeAccent,),
                      title: Text(snapshot.data!.docs[index]['text']),
                      trailing:

                      snapshot.data!.docs[index]['isfree'] ? Icon(Icons.lock_open):Icon(Icons.lock)

                    ),
                  );
              },
            );
          })
    );
  }
}

/*
class featuredmusic extends StatefulWidget {
  const featuredmusic({Key? key}) : super(key: key);

  @override
  State<featuredmusic> createState() => _featuredmusicState();
}

class _featuredmusicState extends State<featuredmusic> {

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

  CollectionReference audiolist= FirebaseFirestore.instance.collection('audiolist');

  late Stream<List<FileData>> _filesStream;
  late List<FileData> _files;

  @override
  void initState() {
    super.initState();
    _filesStream = FirebaseFirestore.instance
        .collection('audiolist')
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => FileData(
      name: doc['audioname'],
      isFree: doc['isFree'],
    ))
        .toList());
  }

  void addmusic(){

  }

  void buypremium(){
    Navigator.push(context, CupertinoPageRoute(
        fullscreenDialog: true,
        builder: (_)=>buypremiumpage()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.indigoAccent,
        appBar: AppBar(
          backgroundColor: Colors.indigoAccent,
          elevation: 0,
          title: Text('Featured Music'),
        ),
        body:  StreamBuilder(
            stream: audiolist.snapshots(),
            builder: (context,snapshot){
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading");
              }


              return ListView.builder(
                itemCount:snapshot.data!.docs.length,
                itemBuilder: (context,index){
                  return InkWell(
                    onTap: (){
                      setState(() {
                        Navigator.push(context, CupertinoPageRoute(
                            fullscreenDialog: true,
                            builder: (_)=>
                            snapshot.data!.docs[index]['isfree'] ?
                            buypremiumpage():textaudioform()

                        ));
                      });
                    },
                    child: Container(
                      height: 70,
                      width: 90,
                      color: Colors.white,
                    ),
                  );

                  /*
                    ListTile(

                    onTap:
                    //snapshot.data!.docs[index]['isfree'] ? addmusic: buypremium ,
                    (){
                      Navigator.push(context, CupertinoPageRoute(
                          fullscreenDialog: true,
                          builder: (_)=>
                          snapshot.data!.docs[index]['isfree'] ?
                          featuredAudioListPage():textaudioform()

                      ));
                    },
                      leading: Icon(Icons.library_music_rounded,color: Colors.orangeAccent,),
                      title: Text(snapshot.data!.docs[index]['audioname']),
                      trailing:

                      snapshot.data!.docs[index]['isfree'] ?
                      Icon(Icons.lock_open):Icon(Icons.lock)

                  ); */
                },
              );
            })
    );
  }
}
*/