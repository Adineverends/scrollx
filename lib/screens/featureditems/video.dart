
import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class FileData {
  final String name;
  final bool isFree;

  const FileData({required this.name, required this.isFree});
}


class featuredAudioListPage extends StatefulWidget {
  @override
  _featuredAudioListPageState createState() => _featuredAudioListPageState();
}

class _featuredAudioListPageState extends State<featuredAudioListPage> {
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
                  return Container(
                    //height: 70,
                    margin: EdgeInsets.only(top: 10,left: 14,right: 14),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: ListTile(

                        leading: Icon(Icons.library_music_rounded,color: Colors.orangeAccent,),
                        title: Text(snapshot.data!.docs[index]['audioname']),
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

  CollectionReference audiolist= FirebaseFirestore.instance.collection('videolist');

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
                  return Container(
                    //height: 70,
                    margin: EdgeInsets.only(top: 10,left: 14,right: 14),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: ListTile(

                        leading: Icon(Icons.library_music_rounded,color: Colors.orangeAccent,),
                        title: Text(snapshot.data!.docs[index]['videoname']),
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
