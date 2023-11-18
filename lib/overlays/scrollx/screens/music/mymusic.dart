/*

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';


class mymusic extends StatefulWidget {
  const mymusic({Key? key}) : super(key: key);

  @override
  State<mymusic> createState() => _mymusicState();
}

class _mymusicState extends State<mymusic> {

 late AudioPlayer  _audioPlayer;











 @override
  void initState() {
    // TODO: implement initState
   _audioPlayer=AudioPlayer()..setAsset('images/m.mp3');



    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [


    controls(audioPlayer: _audioPlayer),








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


import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';




class musicorvoice extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _musicorvoiceState();
}

class _musicorvoiceState extends State<musicorvoice> {
  AudioPlayer _audioPlayer = AudioPlayer();
  String  ? _filePath;
  bool _isPlaying = false;

  Future<void> _pickAudioFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.audio,
      );
      if (result != null) {
        PlatformFile file = result.files.first;
        setState(() {
          _filePath = file.path;
        });
      }
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    }
  }




  @override
  void dispose() {
    // TODO: implement dispose
    _audioPlayer.dispose();
    super.dispose();
  }



  Future<void> _playAudio() async {
    if (_filePath != null && !_isPlaying) {
      await _audioPlayer.play(_filePath!);
      setState(() {
        _isPlaying = true;
      });
    }
  }

  Future<void> _stopAudio() async {
    if (_isPlaying) {
      await _audioPlayer.stop();
      setState(() {
        _isPlaying = false;
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Audio Player'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _pickAudioFile,
                child: Text('Pick Audio File'),
              ),
              if (_filePath != null)
                Column(
                  children: [
                    SizedBox(height: 20),
                    Text(
                      'Selected file: ${
                          _filePath


                              ?.split('/').last}',
                      style: TextStyle(fontSize: 16),
                    ),

                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _playAudio,
                      child: Text('Play'),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _stopAudio,
                      child: Text('Stop'),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}






