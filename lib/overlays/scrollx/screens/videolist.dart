import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:video_player/video_player.dart';

class videoption extends StatefulWidget {
  const videoption({Key? key}) : super(key: key);

  @override
  State<videoption> createState() => _videoptionState();
}

class _videoptionState extends State<videoption> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,

          child: Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              backgroundColor: Colors.black,
              title: Text('Videos',style: TextStyle(color: Colors.white),),
              bottom: TabBar(
                  dividerColor: Colors.redAccent,
                  // labelColor: Colors.redAccent,
                  indicatorColor: Colors.redAccent,
                  tabs: [
                    Tab(
                      text: 'FEATURED',


                    ),
                    Tab(text: 'My Videos'),

                  ]),
            ),
            body: TabBarView(
              children: [
                VideoList(),
                myvideos()

              ],
            ),
          ),

      );

  }
}


class VideoList extends StatefulWidget {
  @override
  _VideoListState createState() => _VideoListState();
}

class _VideoListState extends State<VideoList> {
  late List<VideoPlayerController> _controllers;

  @override
  void initState() {
    super.initState();
    _controllers = [];
    _getVideosFromFirebase();
  }

  Future<void> _getVideosFromFirebase() async {
    final FirebaseStorage storage = FirebaseStorage.instance;
    ListResult result =
    await storage.ref().child('videos/').listAll();

    List<VideoPlayerController> controllers = [];
    for (Reference ref in result.items) {
      VideoPlayerController controller =
      VideoPlayerController.network(await ref.getDownloadURL());
      controllers.add(controller);
      await controller.initialize();
      controller.setLooping(true);
      controller.play();
    }

    setState(() {
      _controllers = controllers;
    });
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: Center(
        child: _controllers.isEmpty
            ? Text(
          'No videos found',
          style: TextStyle(color: Colors.white),
        )
            : ListView.builder(
          itemCount: _controllers.length,
          itemBuilder: (context, index) {
            VideoPlayerController controller = _controllers[index];
            return Padding(
              padding: const EdgeInsets.only(left: 15,right: 15,top: 55,bottom: 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(17),
                child: Container(
                    height: 550,
                    child: VideoPlayer(controller)),
              ),
            );
          },
        ),
      ),



    );
  }
}

class myvideos extends StatefulWidget {
  const myvideos({Key? key}) : super(key: key);

  @override
  State<myvideos> createState() => _myvideosState();
}

class _myvideosState extends State<myvideos> {

  VideoPlayerController ? _controller;
  File ? _videoFile;
  bool _isPlaying = false;
  bool _isUploading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _pickVideo() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.video,
    );
    if (result != null) {
      _videoFile = File(result.files.single.path!);
      _controller = VideoPlayerController.file(_videoFile!)
        ..initialize().then((_) {
          setState(() {
            _isPlaying = true;
          });
          _controller!.play();
        });
    }
  }




  void _uploadVideos() async {
    setState(() {
      _isUploading = true;
    });

    FirebaseStorage storage = FirebaseStorage.instance;
    Reference storageReference = storage.ref().child('myvideos/${_videoFile!.path.split('/').last}');
    UploadTask uploadTask = storageReference.putFile(_videoFile!);
    await uploadTask.whenComplete(() =>
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Video Submitted'))
        )
    );
    setState(() {
      _isUploading = false;
    });
  }



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
    return Padding(
      padding: const EdgeInsets.only(left: 30,top: 20,right: 30),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Choose Your  ',style: TextStyle(color: Colors.white,fontSize: 37,fontWeight: FontWeight.bold,letterSpacing: 2),),
            GradientText(
              'Video',
              style: TextStyle(
                  fontSize: 37.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2
              ),
              colors: [
                Colors.red,
                Colors.pinkAccent,
                Colors.red,
              ],
            ),
            SizedBox(height: 40,),


                //:

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
                          color: Colors.redAccent,
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
                InkWell(
                  onTap: (){
                    setState(() {


                      //     _pickImage();

                      setState(() {
                        _pickVideo();
                      });


                    });
                  },
                  child: Container(
                    width: 340,
                    height: 65,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: LinearGradient(
                            colors: [
                              Colors.red,
                              Colors.pinkAccent,
                              Colors.red
                            ]
                        )
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Choose again' ,
                          style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.bold),
                        ),

                      ],
                    ),
                  ),
                ),
              ],
            )
            :InkWell(
                onTap: (){
                  //    _pickImage();
                  _pickVideo();
                },
                child: Column(
                  children: [
                    Image.asset('images/gal.png'),
                    Text('Click here ',style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.w500,letterSpacing: 2),),
                  ],
                )),


            SizedBox(height: 36),
            












            InkWell(
              onTap: (){
                setState(() {



                  _isUploading ? null : _uploadVideos();


                });
              },
              child: Container(
                width: 340,
                height: 65,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                        colors: [
                          Colors.red,
                          Colors.pinkAccent,
                          Colors.red
                        ]
                    )
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                _isUploading ? 'Uploading...' : 'Submit',
                      style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.bold),
                    ),

                  ],
                ),
              ),
            ),
            SizedBox(height: 30,),
          ],
        ),
      ),
    );
  }
}
class VideoProvider extends ChangeNotifier {
  late VideoPlayerController _controller;
  late File _selectedVideoFile;

  // getters and setters for _controller and _selectedVideoFile

  void pickVideo() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.video,
    );

    if (result == null || result.files.single.path == null) {
      return;
    }

    final file = File(result.files.single.path!);
    _selectedVideoFile = file;
    _controller = VideoPlayerController.file(_selectedVideoFile);
    _controller.addListener(() {
      if (!_controller.value.isPlaying &&
          _controller.value.isInitialized) {
        notifyListeners();
      }
    });
    notifyListeners();
  }

  Future<void> uploadVideoToFirebase() async {
    if (_selectedVideoFile == null) {
      return;
    }

    final storageRef = FirebaseStorage.instance
        .ref()
        .child('videos')
        .child('${DateTime.now().millisecondsSinceEpoch}.mp4');

    final uploadTask = storageRef.putFile(_selectedVideoFile);

    await uploadTask.whenComplete(() => null);

    final downloadUrl = await storageRef.getDownloadURL();

    print('Video uploaded to Firebase: $downloadUrl');
  }
}