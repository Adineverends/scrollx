import 'dart:io';


import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:uuid/uuid.dart';
import 'package:video_player/video_player.dart';

class adminopt extends StatefulWidget {
  const adminopt({Key? key}) : super(key: key);

  @override
  State<adminopt> createState() => _adminoptState();
}

class _adminoptState extends State<adminopt> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('home',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (_)=>ImageListPage()));
            },
                child: Text('image')

            ),
            ElevatedButton(onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (_)=>AudioListPage()));
            },
                child: Text('audio')

            ),
            ElevatedButton(onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (_)=>videouploadpage()));
            },
                child: Text('video')

            ),
          ],
        ),
      ),
    );
  }
}


class ImageListPage extends StatefulWidget {
  @override
  _ImageListPageState createState() => _ImageListPageState();
}

class _ImageListPageState extends State<ImageListPage> {






  File ? _image;
  final TextEditingController _textController = TextEditingController();
  bool _isfree = false;
  Future pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null) {
      setState(() {
        _image = File(result.files.single.path!);
      });
    } else {
      // User canceled the picker
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Audio List'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 80,left: 30,right: 30),
          child: Column(
            children: [
              TextField(
                controller: _textController,
                decoration: InputDecoration(
                  hintText: 'Enter image name',

                ),
              ),
              SizedBox(height: 20,),
              InkWell(
                onTap: (){
                  setState(() {
                    pickImage();
                  });
                },
                child: Container(
                  height: 60,
                  width: 380,
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: Colors.black,
                  ),
                  child:

                  Text('choose image',style: TextStyle(color: Colors.white,fontSize: 20)),
                ),
              ),SizedBox(height: 20,),
              _image == null?
              Container():
              Text(_image!.path),
              _image == null?
              Container():
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.file(_image!),
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  Text('Is Free?',style: TextStyle(fontSize: 20),),
                  Checkbox(
                    value: _isfree,

                    onChanged: (value) {
                      setState(() {
                        _isfree = value!;
                      });
                    },
                  ),
                ],
              ),
              InkWell(
                onTap: (){
                  setState(() async {
                    Reference storageReference =
                    FirebaseStorage.instance.ref().child('imagepanellist/${DateTime.now()}.jpg');
                    UploadTask uploadTask = storageReference.putFile(_image!);
                    TaskSnapshot storageTaskSnapshot = await uploadTask.whenComplete(() => null);
                    String downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();

                    // Upload text and image URL to Cloud Firestore
                    FirebaseFirestore.instance.collection('imagepanellist').add({
                      'text': _textController.text,
                      'image': downloadUrl,

                      'isfree':_isfree
                    });

                    // Navigate to ItemListPage after adding item

                  });
                },
                child: Container(
                  height: 60,
                  width: 380,
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: Colors.black,
                  ),
                  child:
                  // _isUploading ? Text('Uploading......',style: TextStyle(color: Colors.white,fontSize: 20)):
                  Text('Upload',style: TextStyle(color: Colors.white,fontSize: 20)),
                ),
              )

              /*
              if (_isUploading) CircularProgressIndicator(),

              Expanded(
                child: ListView.builder(
                  itemCount: _audioList.length,
                  itemBuilder: (BuildContext context, int index) {
                    String filePath = _audioList[index];
                    bool isPlaying = _currentIndex == index;
                    return ListTile(
                      title: Text(filePath.split('/').last),
                      leading: IconButton(
                          onPressed: (){
                            _uploadAudio(filePath);
                          },
                          icon: Icon(Icons.upload)
                      ),
                      trailing: isPlaying
                          ? IconButton(
                        onPressed: _pauseAudio,
                        icon: Icon(Icons.pause),
                      )
                          : IconButton(
                        onPressed: () => _playAudio(filePath, index),
                        icon: Icon(Icons.play_arrow),
                        disabledColor: Colors.grey,
                        color: Colors.blue,
                      ),
                    );
                  },
                ),
              ),*/


            ],
          ),
        ),
      ),

    );
  }
}

class videouploadpage extends StatefulWidget {
  @override
  _videouploadpageState createState() => _videouploadpageState();
}

class _videouploadpageState extends State<videouploadpage> {






  File ? _video;
  final TextEditingController _textController = TextEditingController();
  bool _isfree = false;
  Future<void> _pickVideo() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.video,
    );
    if (result != null) {
      _video = File(result.files.single.path!);
      _controller = VideoPlayerController.file(_video!)
        ..initialize().then((_) {
          setState(() {
            _isPlaying = true;
          });
          _controller!.play();
        });
    }
  }

  File ? _image;

  Future pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null) {
      setState(() {
        _image = File(result.files.single.path!);
      });
    } else {
      // User canceled the picker
    }
  }
  VideoPlayerController ? _controller;
  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
  bool _isPlaying = false;

  void _togglePlaying() {
    setState(() {
      _isPlaying = !_isPlaying;
      if (_isPlaying) {
        _controller!.play();
      } else {
        _controller!.pause();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Audio List'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 80,left: 30,right: 30),
          child: Column(
            children: [
              TextField(
                controller: _textController,
                decoration: InputDecoration(
                  hintText: 'Enter image name',

                ),
              ),
              SizedBox(height: 20,),

              InkWell(
                onTap: (){
                  setState(() {
                    pickImage();
                  });
                },
                child: Container(
                  height: 60,
                  width: 380,
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: Colors.black,
                  ),
                  child:

                  Text('choose image',style: TextStyle(color: Colors.white,fontSize: 20)),
                ),
              ),SizedBox(height: 20,),
              _image == null?
              Container():
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.file(_image!),
              ),
              SizedBox(height: 20,),
              InkWell(
                onTap: (){
                  setState(() {
                    _pickVideo();
                  });
                },
                child: Container(
                  height: 60,
                  width: 380,
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: Colors.black,
                  ),
                  child:

                  Text('choose video',style: TextStyle(color: Colors.white,fontSize: 20)),
                ),
              ),SizedBox(height: 20,),
              _video==null?Container():
              Text(_video!.path),
              SizedBox(height: 20,),

              _controller != null && _controller!.value.isInitialized
                  ?  Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: AspectRatio(
                      aspectRatio: _controller!.value.aspectRatio,
                      child: Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          VideoPlayer(_controller!),
                          IconButton(
                            icon: Icon(
                              _controller!.value.isPlaying
                                  ? Icons.pause
                                  : Icons.play_arrow,
                            ),
                            iconSize: 64.0,
                            color: Colors.white,
                            onPressed: () {
                              setState(() {
                                _controller!.value.isPlaying
                                    ? _controller!.pause()
                                    : _controller!.play();
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 26),

                ],
              )
                  : Container(),

              Row(
                children: [
                  Text('Is Free?',style: TextStyle(fontSize: 20),),
                  Checkbox(
                    value: _isfree,

                    onChanged: (value) {
                      setState(() {
                        _isfree = value!;
                      });
                    },
                  ),
                ],
              ),
              InkWell(
                onTap: (){
                  setState(() async {
                    Reference storageReference =
                    FirebaseStorage.instance.ref().child('videolist/${DateTime.now()}.mp4');
                    UploadTask uploadTask = storageReference.putFile(_video!);
                    TaskSnapshot storageTaskSnapshot = await uploadTask.whenComplete(() => null);
                    String downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();

                    Reference imgReference =
                    FirebaseStorage.instance.ref().child('thumnailimage/${DateTime.now()}.jpg');
                    UploadTask imguploadTask = imgReference.putFile(_image!);
                    TaskSnapshot imgstorageTaskSnapshot = await imguploadTask.whenComplete(() => null);
                    String imagedownloadUrl = await imgstorageTaskSnapshot.ref.getDownloadURL();

                    // Upload text and image URL to Cloud Firestore
                    FirebaseFirestore.instance.collection('videolist').add({
                      'text': _textController.text,
                      'video': downloadUrl,
                      'thumbnail':imagedownloadUrl,


                      'isfree':_isfree
                    });

                    // Navigate to ItemListPage after adding item

                  });
                },
                child: Container(
                  height: 60,
                  width: 380,
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: Colors.black,
                  ),
                  child:
                  // _isUploading ? Text('Uploading......',style: TextStyle(color: Colors.white,fontSize: 20)):
                  Text('Upload',style: TextStyle(color: Colors.white,fontSize: 20)),
                ),
              )

              /*
              if (_isUploading) CircularProgressIndicator(),

              Expanded(
                child: ListView.builder(
                  itemCount: _audioList.length,
                  itemBuilder: (BuildContext context, int index) {
                    String filePath = _audioList[index];
                    bool isPlaying = _currentIndex == index;
                    return ListTile(
                      title: Text(filePath.split('/').last),
                      leading: IconButton(
                          onPressed: (){
                            _uploadAudio(filePath);
                          },
                          icon: Icon(Icons.upload)
                      ),
                      trailing: isPlaying
                          ? IconButton(
                        onPressed: _pauseAudio,
                        icon: Icon(Icons.pause),
                      )
                          : IconButton(
                        onPressed: () => _playAudio(filePath, index),
                        icon: Icon(Icons.play_arrow),
                        disabledColor: Colors.grey,
                        color: Colors.blue,
                      ),
                    );
                  },
                ),
              ),*/


            ],
          ),
        ),
      ),

    );
  }
}

class AudioListPage extends StatefulWidget {
  @override
  _AudioListPageState createState() => _AudioListPageState();
}

class _AudioListPageState extends State<AudioListPage> {






  File ? _audio;
  final TextEditingController _textController = TextEditingController();
  bool _isfree = false;
  Future pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
      allowMultiple: false,
    );

    if (result != null) {
      setState(() {
        _audio = File(result.files.single.path!);
      });
    } else {
      // User canceled the picker
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Audio List'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 80,left: 30,right: 30),
          child: Column(
            children: [
              TextField(
                controller: _textController,
                decoration: InputDecoration(
                  hintText: 'Enter image name',

                ),
              ),
              SizedBox(height: 20,),
              InkWell(
                onTap: (){
                  setState(() {
                    pickImage();
                  });
                },
                child: Container(
                  height: 60,
                  width: 380,
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: Colors.black,
                  ),
                  child:

                  Text('choose audio',style: TextStyle(color: Colors.white,fontSize: 20)),
                ),
              ),SizedBox(height: 20,),
             _audio == null ? Container():
             Text(_audio!.path),
              SizedBox(height: 20,),
              Row(
                children: [
                  Text('Is Free?',style: TextStyle(fontSize: 20),),
                  Checkbox(
                    value: _isfree,

                    onChanged: (value) {
                      setState(() {
                        _isfree = value!;
                      });
                    },
                  ),
                ],
              ),
              InkWell(
                onTap: (){
                  setState(() async {
                    Reference storageReference =
                    FirebaseStorage.instance.ref().child('audiollist/${DateTime.now()}.mp3');
                    UploadTask uploadTask = storageReference.putFile(_audio!);
                    TaskSnapshot storageTaskSnapshot = await uploadTask.whenComplete(() => null);
                    String downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();

                    // Upload text and image URL to Cloud Firestore
                    FirebaseFirestore.instance.collection('audiollist').add({
                      'text': _textController.text,
                      'audio': downloadUrl,

                      'isfree':_isfree
                    });

                    // Navigate to ItemListPage after adding item

                  });
                },
                child: Container(
                  height: 60,
                  width: 380,
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: Colors.black,
                  ),
                  child:
                  // _isUploading ? Text('Uploading......',style: TextStyle(color: Colors.white,fontSize: 20)):
                  Text('Upload',style: TextStyle(color: Colors.white,fontSize: 20)),
                ),
              )

              /*
              if (_isUploading) CircularProgressIndicator(),

              Expanded(
                child: ListView.builder(
                  itemCount: _audioList.length,
                  itemBuilder: (BuildContext context, int index) {
                    String filePath = _audioList[index];
                    bool isPlaying = _currentIndex == index;
                    return ListTile(
                      title: Text(filePath.split('/').last),
                      leading: IconButton(
                          onPressed: (){
                            _uploadAudio(filePath);
                          },
                          icon: Icon(Icons.upload)
                      ),
                      trailing: isPlaying
                          ? IconButton(
                        onPressed: _pauseAudio,
                        icon: Icon(Icons.pause),
                      )
                          : IconButton(
                        onPressed: () => _playAudio(filePath, index),
                        icon: Icon(Icons.play_arrow),
                        disabledColor: Colors.grey,
                        color: Colors.blue,
                      ),
                    );
                  },
                ),
              ),*/


            ],
          ),
        ),
      ),

    );
  }
}