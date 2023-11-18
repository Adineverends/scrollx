import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:chewie/chewie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:lottie/lottie.dart';
import 'package:scrollx/screens/addedremindersinhome/textaudioreminder.dart';
import 'package:scrollx/screens/database/sqflite.dart';
import 'package:scrollx/screens/featureditems/music.dart';
import 'package:scrollx/screens/home.dart';
import 'package:scrollx/screens/navitems/homepage.dart';
import 'package:video_player/video_player.dart';

import '../buypremiumpage/premiumpage.dart';
import '../featureditems/image.dart';
import '../featureditems/music.dart';
import '../database/textaudioformdatabase.dart';
import '../timer/texttimer.dart';
import '../timer/timerscreen.dart';

class textaudioform extends StatefulWidget {
  String featuredfilepath;
  String featuredimagepath;
  
   textaudioform({Key? key,required this.featuredfilepath,required this.featuredimagepath}) : super(key: key);

  @override
  State<textaudioform> createState() => _textaudioformState();
}

class _textaudioformState extends State<textaudioform> {


  TextEditingController _textContoller=TextEditingController();

  int _wordCount = 0;
  String a='';
  bool _showCancelIcon = false;
  String ? selectedmusic;
  List<bool> _isSelected = [false, false, false];
  String ? text;
  int ? hour;
  int ? minute;
  int ? second;
  bool isAm = true;

  AudioPlayer _audioPlayer = AudioPlayer();



  VideoPlayerController ? _controller;
  ChewieController ? _chewieController;
  @override
  void initState() {
    super.initState();
    _textContoller.addListener(_validateInputs);

    if (_videoFile != null) {
      _controller = VideoPlayerController.file(_videoFile!);
      _chewieController = ChewieController(
          videoPlayerController: _controller!,
          autoPlay: true,
          looping: true,
          fullScreenByDefault: true
      );
    }



  }

  @override
  void dispose() {
    _controller!.dispose();
    _chewieController!.dispose();
    _textContoller.dispose();
    _audioPlayer.dispose();
    _textEditingController.dispose();
    _timer?.cancel();
    super.dispose();
  }




  Timer? _timer;



  void _showCancelIconChanged(String text) {
    setState(() {
      _showCancelIcon = text.isNotEmpty;
    });
  }



  void _wordCountChanged(String text) {
    setState(() {
      _wordCount = text.split(' ').where((word) => word.isNotEmpty).length;
    });
  }

  void _clearText() {
    setState(() {


      _textContoller.clear();
      _wordCount = 0;

    });
  }




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
    _validateInputs();
  }






  Future<void> _playAudio() async {
    if (_filePath != null && !_isPlaying) {
      await _audioPlayer.play(


          _filePath!

      );
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


  String _selectedName = "";
  String _selectedImage = "";
  bool _isButtonEnabled=false;


  void _onListItemSelected(String name, String image) {
    setState(() {
      _selectedName = name;
      _selectedImage = image;
      _isButtonEnabled=true;
    });
  }








  List<Map<String, dynamic>> myData = [];




  final formKey = GlobalKey<FormState>();
  Future<void> addItem() async {
//Navigator.of(context).push(MaterialPageRoute(builder: (_)=>textaudioreminder()));
    await databaseHelper.createItem(
      //  _textContoller.text,

    _filePath! ,
      //  _time as int

    );

   // _refreshData();
  }

  void submit(int? id) async{
    if (id != null) {
      final existingData = myData.firstWhere((element) => element['id'] == id);
      _textContoller.text = existingData['text'];

    } else {
      _textContoller.text = "";

    }

    if (formKey.currentState!.validate()) {
      if (id == null) {
        await addItem();
      }



      // Clear the text fields
      setState(() {
        _textContoller.text = '';

      });

      // Close the bottom sheet
      Navigator.pop(context);
    }
  }

  bool _isButton1Selected = true;

  TextEditingController _hourController = TextEditingController();
  TextEditingController _minuteController = TextEditingController();
  bool _amSelected = true;
  bool _canSubmit = false;


  TimeOfDay _time = TimeOfDay.now();

  void _validateInputs() {
    setState(() {
      _canSubmit =
          _textContoller.text.isNotEmpty &&
              _filePath != null &&
              _time != null;

    });
  }

  TextEditingController _textEditingController = TextEditingController();
//  int _wordCount = 0;



  int min = 0;
  int max = 120;


  void start() async {
    // Navigator.of(context).push(MaterialPageRoute(builder: (_)=>Recipes()));
    // String time=_time.format(context);


    if ( _textEditingController.text.isNotEmpty) {
      Navigator.of(context).push(
          CupertinoPageRoute(
              fullscreenDialog: true,
              builder: (_)=>timerscreen(totalSeconds:int.parse(_textEditingController.text) * 60 ,)

          ));
    }






  }

  File? _imageFile;
  String? _selectedImageUrl='' ;

  Future<void> _pickImageFromDevice() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null && result.files.isNotEmpty) {
      setState(() {
        _imageFile = File(result.files.single.path!);
        _selectedImageUrl = null;
      });
    }
  }

  File? _videoFile;
  String? _selectedVideoUrl='';

  Future<void> _pickVideoFromDevice() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.video,
      allowMultiple: false,
    );

    if (result != null && result.files.isNotEmpty) {
      setState(() {
        _videoFile = File(result.files.single.path!);
        _selectedVideoUrl = null;
      });
    }
  }





  void _showBottomSheet(BuildContext context) async {
    showModalBottomSheet(
      enableDrag: false,
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.indigoAccent,
            elevation: 0,
            title: Text('Custom Timer'),
          ),
          backgroundColor: Colors.indigoAccent,
          resizeToAvoidBottomInset: false, // This line is important
          body: Container(
            height: MediaQuery.of(context).size.height,
            margin: EdgeInsets.only(top: 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Padding(
                  padding: const EdgeInsets.only(left: 60),
                  child: Row(
                    children: [
                      Container(
                        height: 50,
                        width: 200,
                        child: TextField(
                          controller: _textEditingController,
                          /*
                            onChanged: (String value) {
                              print('Changed');
                              int x;
                              try {
                                x = int.parse(value);
                              } catch (error) {
                                x = min;
                              }
                              if (x < min) {
                                x = min;
                              } else if (x > max) {
                                x = max;
                              }

                              _textEditingController.value = TextEditingValue(
                                text: x.toString(),
                                selection: TextSelection.fromPosition(
                                  TextPosition(offset: _textEditingController.value.selection.baseOffset),
                                ),
                              );
                            },*/

                          textAlign: TextAlign.right, // Set text alignment to right
                          cursorColor: Colors.white,
                          maxLength: 3,

                          autofocus: true,
                          keyboardType: TextInputType.number,
                          //maxLines: 1,
                          style: TextStyle(fontSize: 94,color: Colors.white),
                          cursorHeight: 100,
                          decoration: InputDecoration(
                            // hintText: 'Enter text',
                              border: InputBorder.none,
                              counterStyle: TextStyle(color: Colors.white)
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 40,left: 10),
                        child: Text('mins',style: TextStyle(color: Colors.white),),
                      )
                    ],
                  ),
                )
                ,
                SizedBox(height: 26,),
                Opacity(
                  opacity: 0.5,
                  child: Container(
                    height: 50,
                    width: 340,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.indigo.shade500.withOpacity(0.9)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('images/al.png',color: Colors.white,height: 25,),
                        SizedBox(width: 20,),
                        Text('Maximum lock duration is 120 minutes',style: TextStyle(color: Colors.white,fontSize: 15),)
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 56,),
                TextButton(
                  onPressed: () async {
                    final bool? res =
                    await FlutterOverlayWindow.requestPermission();
                    log("status: $res");
                  },
                  child: const Text("Request Permission"),
                ),
                InkWell(
                  onTap: (){
                    setState(() {
                      start();

                    });
                  },
                  child: Container(
                    height: 50,
                    width: 340,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white
                    ),
                    child: Text('Start the Reminder',style: TextStyle(color: Colors.indigoAccent,fontSize: 16,fontWeight: FontWeight.w500,letterSpacing: 1),),
                  ),
                ),
                SizedBox(height: 26,),


                InkWell(
                    onTap: (){
                      setState(() {
                        Navigator.of(context).push(
                            CupertinoPageRoute(
                                fullscreenDialog: true,
                                builder: (_)=>home())

                        );
                      });
                    },
                    child: Text('Dismiss',style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.w500,letterSpacing: 1),)),


              ],
            ),
          ),
        ),
      ),
    );
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


  void _showfeaturedimagebottomshhet(BuildContext context) async {

    final result = await showModalBottomSheet(context: context,
        enableDrag: false,

        isScrollControlled: true,
        builder: (context) => Padding(
            padding: EdgeInsets.only(top: 30),
          child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.indigoAccent,
                elevation: 0,
                title: Text('Featured Image'),
              ),
              backgroundColor: Colors.indigoAccent,
              resizeToAvoidBottomInset: false,
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('imagelist').snapshots(),
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
                            data['isfree']?
                          // Navigator.pop(context,data['image'])
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>textaudioform(featuredfilepath: '', featuredimagepath:  data['image'])))
                            // detailed(data['image'],data['isfree'])
                                :  buypremium();
                          });
                        },


                        onLongPress: (){
                          showDialog(context: context,
                              builder: (context){
                                return Padding(
                                    padding: const EdgeInsets.all(25.0),
                                    child: Container(
                                      height: 300,
                                      width: 250,
                                      //    margin: EdgeInsets.all(10),
                                      alignment: Alignment.topRight,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(data['image']),
                                              fit: BoxFit.cover
                                          ),
                                          borderRadius: BorderRadius.circular(18)
                                      ),
                                      //child: Icon(Icons.cancel,color: Colors.yellow,),
                                    )
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
                              image: DecorationImage(
                                  image: NetworkImage(data['image']),
                                  fit: BoxFit.cover
                              )
                          ),
                          child: data['isfree'] ? Icon(Icons.lock_open):Icon(Icons.lock),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            )
          ),

        )

    );

    setState(() {
      _selectedImageUrl = result;
    });
  }


  void _showfeaturedvideobottomshhet(BuildContext context) async {

    final result = await showModalBottomSheet(context: context,
        enableDrag: false,

        isScrollControlled: true,
        builder: (context) => Padding(
          padding: EdgeInsets.only(top: 30),
          child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.indigoAccent,
                elevation: 0,
                title: Text('Featured Video'),
              ),
              backgroundColor: Colors.indigoAccent,
              resizeToAvoidBottomInset: false,
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('videolist').snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }

                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 0.7
                      ),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot videoData = snapshot.data!.docs[index];
                        String videoUrl = videoData['video'];

                        return GestureDetector(
                          onTap: () {

                            setState(() {
                              videoData['isfree']?
                              Navigator.pop(context,videoData['video'])

                              // detailed(data['image'],data['isfree'])
                                  :  buypremium();
                            });



                          },
                          onDoubleTap: (){
                            videoData['isfree']?
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => VideoPlayerScreen(videoUrl),
                              ),
                            )  :  buypremium();
                          },


                          child: Container(
                            alignment: Alignment.topRight,
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,

                              borderRadius: BorderRadius.circular(16),

                              image: DecorationImage(
                                image: NetworkImage(
                                //  'https://i.pinimg.com/236x/68/82/8f/68828f2375fa94e4defdf783e0af0184.jpg',
                                    videoData['thumbnail']
                                ),
                                fit: BoxFit.cover
                              )
                            ),
                            child:
                            videoData['isfree']?Icon(

                              Icons.lock_open,
                              size: 30,
                              color: Colors.grey,
                            ):
                            Icon(

                              Icons.lock,
                              size: 30,
                              color: Colors.orangeAccent,

                            ),
                          ),
                        );
                      },
                    );

                  },
                ),
              )
          ),

        )

    );

    setState(() {
      _selectedVideoUrl = result;
    });
  }

  String selectedButton = '';

  void selectButton(String button) {
    setState(() {
      selectedButton = button;
    });
  }

  File? selectedFile;

  Future<void> selectFeaturedMusic() async {
    String? selectedPath = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => featuredmusicListPage()),
    );
    if (selectedPath != null) {
      setState(() {
        selectedFile = File(selectedPath);
      });
    }
  }

  Future<void> _pickAudiofile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.audio,
      );
      if (result != null) {
        PlatformFile file = result.files.first;
        setState(() {
          selectedFile = File(result.files.single.path!);
        });
      }
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    }
    _validateInputs();
  }

  Future<void> playMusic() async {
    if (selectedFile != null) {
      AudioPlayer player = AudioPlayer();
      await player.play(selectedFile!.path,
          isLocal: true
      );
    }
  }

  Future<void> selectFeaturedImage() async {
     await Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => featuredimagelistpage()),
    );

  }


  bool _showContainer1 = false;
  bool _showContainer2 = false;

  void _toggleContainer1() {
    setState(() {
      _showContainer1 = !_showContainer1;
      _showContainer2 = false;
    });
  }

  void _toggleContainer2() {
    setState(() {
      _showContainer2 = !_showContainer2;
      _showContainer1 = false;
    });
  }

  String ? featuredimage;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(  backgroundColor: Colors.grey.shade100,

        body: SingleChildScrollView(
          child: Column(
            children:[
            Container(
              height: 60,
              width: double.infinity,
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 10,top: 10),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                // borderRadius: BorderRadius.only(topLeft: Radius.circular(20))
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: Image.asset('images/cross.png'),
                        onPressed: (){
                          Navigator.pop(context);
                        },

                      ),
                      SizedBox(width: 10,),
                      Text('Reminder Form',style: TextStyle(color: Colors.black,
                          fontWeight: FontWeight.bold,fontSize: 29
                      ),),


                    ],
                  ),
                  SizedBox(height: 3,),
                  Container(
                    height: 5,
                    width: 50,
                    margin: EdgeInsets.only(left: 62),
                    decoration: BoxDecoration(
                        color: Colors.indigoAccent.shade400,
                        borderRadius: BorderRadius.circular(20)
                    ),
                  )
                ],
              ),
            ),


              Container(
                height: 647,
margin: EdgeInsets.only(left: 15,right: 15),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 12,),
                      Text('Reminder Text ',style: TextStyle(color: Colors.grey.shade700,fontSize: 18,fontWeight: FontWeight.w500
                      ),
                      ), SizedBox(height: 9,),
                      Container(
                        height: _wordCount * 30.0 + 90.0,
                        width: 380,
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(left: 15,),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            //    border: Border.all(color: Colors.grey,)
                            borderRadius: BorderRadius.circular(12)
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              child: TextField(




                                style: TextStyle(
                                    color: Colors.black
                                ),
                                controller: _textContoller,
                                maxLines: 6,

                                onChanged: _wordCountChanged,
                                decoration: InputDecoration(

                                  hintText: " Enter Your Text message for Reinder!",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none,



                                ),
                                cursorColor: Colors.indigoAccent,

                              ),
                            ),

                            Align(
                              alignment: Alignment.bottomRight,
                              child: IconButton(
                                icon: Icon(Icons.cancel,color: Colors.black,),
                                onPressed: _clearText,

                              ),
                            ),
                            //   SizedBox(height: 16.0),

                            /*
                                                           MaterialButton(
                                                             color: _wordCount > 3 ? Colors.blue : Colors.grey,
                                                             onPressed: () {},
                                                             child: Text('Submit'),
                                                           ),
                                                 */
                          ],
                        ),


                      ),
                      SizedBox(height: 20,),

                      Text('Reminder Display ',style: TextStyle(color: Colors.grey.shade700,fontSize: 18,fontWeight: FontWeight.w500
                      ),
                      ),
                      SizedBox(height: 9,),



                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 70),
                        child:   Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            InkWell(
                              onTap:  _toggleContainer1,




                              child: Column(

                                children: [



                                  Container(

                                    height: 48,

                                    width: 90,

                                    padding: EdgeInsets.all(13),

                                    decoration: BoxDecoration(

                                        color:
                                       // _isButton1Selected ?
                                        Colors.indigoAccent.shade400
                                            //: Colors.grey,








                                        //  border: Border.all(color: Colors.redAccent,)

                                        //  borderRadius: BorderRadius.circular(20),
                                        ,



                                        borderRadius: BorderRadius.only(

                                            topRight: Radius.circular(17),

                                            topLeft: Radius.circular(17)

                                        )

                                    ),

                                    child: Icon(Icons.video_collection,color: Colors.white,),

                                  ),

                                  Container(

                                    height: 43,

                                    width: 90,

                                    alignment: Alignment.center,

                                    padding: EdgeInsets.all(13),

                                    decoration: BoxDecoration(

                                        color: Colors.black,


                                        borderRadius: BorderRadius.only(

                                            bottomRight: Radius.circular(12),

                                            bottomLeft: Radius.circular(12)

                                        )
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
                                      //  border: Border.all(color: Colors.redAccent,)

                                      // borderRadius: BorderRadius.circular(20),



                                    ),

                                    child: Text('Video',style: TextStyle(color: Colors.white),),

                                  ),





                                ],

                              ),
                            ),
                            Text('or ',style: TextStyle(color: Colors.grey.shade700,fontSize: 18,fontWeight: FontWeight.w500
                            ),
                            ),
                            InkWell(
                              onTap:
                              //_toggleContainer2

                              (){
                                setState(() {
                                 // Navigator.of(context).push(MaterialPageRoute(builder: (_)=>featuredimagelistpage()));

                                  _pickImageFromDevice();
                                });
                              }
                                ,
                              child: Column(

                                children: [



                                  Container(

                                    height: 48,

                                    width: 90,

                                    padding: EdgeInsets.all(13),

                                    decoration: BoxDecoration(

                                      // color: Colors.indigo,



                                        color:

                                        // _isButton1Selected ? Colors.grey :

                                        Colors.indigoAccent.shade400,

                                        //  border: Border.all(color: Colors.redAccent,)

                                        //  borderRadius: BorderRadius.circular(20),



                                        borderRadius: BorderRadius.only(

                                            topRight: Radius.circular(17),

                                            topLeft: Radius.circular(17)

                                        )

                                    ),

                                    child:Icon(Icons.image,color: Colors.white,),

                                  ),

                                  Container(

                                    height: 43,

                                    width: 90,

                                    alignment: Alignment.center,

                                    padding: EdgeInsets.all(13),

                                    decoration: BoxDecoration(

                                        color: Colors.black,


                                        borderRadius: BorderRadius.only(

                                            bottomRight: Radius.circular(12),

                                            bottomLeft: Radius.circular(12)

                                        )




                                    ),

                                    child: Text('Image',style: TextStyle(color: Colors.white),),

                                  ),





                                ],

                              ),
                            ),

                          ],

                        ),
                      ),

                      SizedBox(height: 20,),


                      // CODE FOR  FEATURED IMAGE AND PATH

                      /*

                      Visibility(
                        visible: _showContainer1,
                        child:        Container(

                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade400,
                            borderRadius: BorderRadius.circular(15)
                          ),
                          child: Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10,left:70,right: 70),
                              child:   Column(
                                children: [
                                  Text('VIDEO',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                                  SizedBox(height: 16,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [

                                      InkWell(
                                        onTap: (){
                                          setState(() {

                                            _showfeaturedvideobottomshhet(context);





                                          });
                                        },

                                        child: Column(

                                          children: [



                                            Container(

                                              height: 48,

                                              width: 90,

                                              padding: EdgeInsets.all(13),

                                              decoration: BoxDecoration(

                                                  color: Colors.indigoAccent.shade400 ,








                                                  //  border: Border.all(color: Colors.redAccent,)

                                                  //  borderRadius: BorderRadius.circular(20),



                                                  borderRadius: BorderRadius.only(

                                                      topRight: Radius.circular(17),

                                                      topLeft: Radius.circular(17)

                                                  )

                                              ),

                                              child: Icon(Icons.star,color: Colors.white,),

                                            ),

                                            Container(

                                              height: 43,

                                              width: 90,

                                              alignment: Alignment.center,

                                              padding: EdgeInsets.all(13),

                                              decoration: BoxDecoration(

                                                  color: Colors.black,


                                                  borderRadius: BorderRadius.only(

                                                      bottomRight: Radius.circular(12),

                                                      bottomLeft: Radius.circular(12)

                                                  )
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
                                                //  border: Border.all(color: Colors.redAccent,)

                                                // borderRadius: BorderRadius.circular(20),



                                              ),

                                              child: Text('Featured',style: TextStyle(color: Colors.white),),

                                            ),





                                          ],

                                        ),
                                      ),
                                      Text('or ',style: TextStyle(color: Colors.grey.shade700,fontSize: 18,fontWeight: FontWeight.w500
                                      ),
                                      ),
                                      InkWell(
                                        onTap: (){
                                          setState(() {
                                            _pickVideoFromDevice();


                                          });
                                        },
                                        child: Column(

                                          children: [



                                            Container(

                                              height: 48,

                                              width: 90,

                                              padding: EdgeInsets.all(13),

                                              decoration: BoxDecoration(

                                                // color: Colors.indigo,



                                                  color: Colors.indigoAccent.shade400,

                                                  //  border: Border.all(color: Colors.redAccent,)

                                                  //  borderRadius: BorderRadius.circular(20),



                                                  borderRadius: BorderRadius.only(

                                                      topRight: Radius.circular(17),

                                                      topLeft: Radius.circular(17)

                                                  )

                                              ),

                                              child: Image.asset('images/device.png',color: Colors.white,),

                                            ),

                                            Container(

                                              height: 43,

                                              width: 90,

                                              alignment: Alignment.center,

                                              padding: EdgeInsets.all(13),

                                              decoration: BoxDecoration(

                                                  color: Colors.black,


                                                  borderRadius: BorderRadius.only(

                                                      bottomRight: Radius.circular(12),

                                                      bottomLeft: Radius.circular(12)

                                                  )




                                              ),

                                              child: Text('My Video',style: TextStyle(color: Colors.white),),

                                            ),





                                          ],

                                        ),
                                      ),

                                    ],

                                  ),
                                  SizedBox(height: 20,),

/*
_videoFile == null ? Container():

    _chewieController == null ? CircularProgressIndicator():
                              Chewie(

                                  controller: _chewieController!), */

                                  _selectedVideoUrl == null ?Container(
                                    height: 200,
                                    width: 150,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      // color: Colors.yellowAccent,
                                        gradient: LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors: [
                                              Colors.red,
                                              Colors.orangeAccent,
                                              Colors.red,
                                            ]
                                        ),
                                        borderRadius: BorderRadius.circular(15)
                                    ),
                                    child: Column(
                                        children: [
                                          SizedBox(height: 60,),
                                          Icon(Icons.video_camera_back),
                                          Text('Your Video')
                                        ]
                                    ),
                                  ):
                                  Container(
                                    height: 200,
                                    width: 150,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      // color: Colors.yellowAccent,
                                        gradient: LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors: [
                                              Colors.red,
                                              Colors.orangeAccent,
                                              Colors.red,
                                            ]
                                        ),
                                        borderRadius: BorderRadius.circular(15)
                                    ),
                                    child: Column(
                                        children: [
                                          SizedBox(height: 60,),
                                          Icon(Icons.star),
                                          Text('Featured video')
                                        ]
                                    ),
                                  ),

                                  SizedBox(height: 20,),

                                ],
                              ),
                            ),
                          ),
                        )
                      ),
                      Visibility(
                          visible: _showContainer2,
                          child:        Container(
                          //  height: 170,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade400,
                                borderRadius: BorderRadius.circular(15)
                            ),
                            child: Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10,left:70,right: 70),
                                child:   Column(
                                  children: [
                                    Text('IMAGE',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                                    SizedBox(height: 16,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [

                                        InkWell(
                                          onTap: (){
                                            setState(() {

                                         //   _showfeaturedimagebottomshhet(context);

                                              Navigator.push(context, MaterialPageRoute(builder: (context) => featuredimagelistpage()))
                                                  .then((value) => setState(() {
                                                featuredimage = value;
                                              }));

                                            });
                                          },

                                          child: Column(

                                            children: [



                                              Container(

                                                height: 48,

                                                width: 90,

                                                padding: EdgeInsets.all(13),

                                                decoration: BoxDecoration(

                                                    color: Colors.indigoAccent.shade400 ,








                                                    //  border: Border.all(color: Colors.redAccent,)

                                                    //  borderRadius: BorderRadius.circular(20),



                                                    borderRadius: BorderRadius.only(

                                                        topRight: Radius.circular(17),

                                                        topLeft: Radius.circular(17)

                                                    )

                                                ),

                                                child: Icon(Icons.star,color: Colors.white,),

                                              ),

                                              Container(

                                                height: 43,

                                                width: 90,

                                                alignment: Alignment.center,

                                                padding: EdgeInsets.all(13),

                                                decoration: BoxDecoration(

                                                    color: Colors.black,


                                                    borderRadius: BorderRadius.only(

                                                        bottomRight: Radius.circular(12),

                                                        bottomLeft: Radius.circular(12)

                                                    )
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
                                                  //  border: Border.all(color: Colors.redAccent,)

                                                  // borderRadius: BorderRadius.circular(20),



                                                ),

                                                child: Text('Featured',style: TextStyle(color: Colors.white),),

                                              ),





                                            ],

                                          ),
                                        ),
                                        Text('or ',style: TextStyle(color: Colors.grey.shade700,fontSize: 18,fontWeight: FontWeight.w500
                                        ),
                                        ),
                                        InkWell(
                                          onTap: (){
                                            setState(() {

                                              _pickImageFromDevice();
                                            });
                                          },
                                          child: Column(

                                            children: [



                                              Container(

                                                height: 48,

                                                width: 90,

                                                padding: EdgeInsets.all(13),

                                                decoration: BoxDecoration(

                                                  // color: Colors.indigo,



                                                    color: Colors.indigoAccent.shade400,

                                                    //  border: Border.all(color: Colors.redAccent,)

                                                    //  borderRadius: BorderRadius.circular(20),



                                                    borderRadius: BorderRadius.only(

                                                        topRight: Radius.circular(17),

                                                        topLeft: Radius.circular(17)

                                                    )

                                                ),

                                                child: Image.asset('images/device.png',color: Colors.white,),

                                              ),

                                              Container(

                                                height: 43,

                                                width: 90,

                                                alignment: Alignment.center,

                                                padding: EdgeInsets.all(13),

                                                decoration: BoxDecoration(

                                                    color: Colors.black,


                                                    borderRadius: BorderRadius.only(

                                                        bottomRight: Radius.circular(12),

                                                        bottomLeft: Radius.circular(12)

                                                    )




                                                ),

                                                child: Text('My Image',style: TextStyle(color: Colors.white),),

                                              ),





                                            ],

                                          ),
                                        ),

                                      ],

                                    ),
                                    SizedBox(height: 20,),
                                  //  Text(_selectedImageUrl!),
                                    //_selectedImageUrl == null ?Container():
                                   
                                    ClipRRect(
                                        borderRadius: BorderRadius.circular(15),

                                        child: _imageFile == null ? Container():Image.file(_imageFile!)
                                        



                                    ),
                                    ClipRRect(
                                        borderRadius: BorderRadius.circular(15),

                                        child: featuredimage == null ? Container():Image.network(featuredimage!)




                                    ),



                                 SizedBox(height: 25,)
                                  ],
                                ),
                              ),
                            ),
                          )
                      ),*/


                    /*
                      Container(
                        height: 450,
                        //         width: 500,
                        padding: EdgeInsets.all(8),
                        alignment: Alignment.topRight,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                                image: NetworkImage(widget.featuredimagepath),
                                fit: BoxFit.cover
                            )
                        ),
                        // child: widget.isfree ? Icon(Icons.lock_open):Icon(Icons.lock),
                      ),*/

                      /*

                      if (_imageFile != null || widget.featuredimagepath != null)
                        SizedBox(
                          height: 200,
                          child: widget.featuredimagepath != null
                              ? Image.network(widget.featuredimagepath)
                              : Image.file(_imageFile!),
                        ),

                       */


                      SizedBox(height: 19,),
                      Text('Reminder Music ',style: TextStyle(color: Colors.grey.shade700,fontSize: 18,fontWeight: FontWeight.w500
                      ),
                      ),
                      SizedBox(height: 9,),




                  //    Image.network(_selectedImage!),


                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 70),
                        child:   Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            InkWell(
                              onTap: (){
                                setState(() {

                                  selectFeaturedMusic();



                                });
                              },

                              child: Column(

                                children: [



                                  Container(

                                    height: 48,

                                    width: 90,

                                    padding: EdgeInsets.all(13),

                                    decoration: BoxDecoration(

                                        color: Colors.indigoAccent.shade400 ,








                                        //  border: Border.all(color: Colors.redAccent,)

                                        //  borderRadius: BorderRadius.circular(20),



                                        borderRadius: BorderRadius.only(

                                            topRight: Radius.circular(17),

                                            topLeft: Radius.circular(17)

                                        )

                                    ),

                                    child: Icon(Icons.star,color: Colors.white,),

                                  ),

                                  Container(

                                    height: 43,

                                    width: 90,

                                    alignment: Alignment.center,

                                    padding: EdgeInsets.all(13),

                                    decoration: BoxDecoration(

                                        color: Colors.black,


                                        borderRadius: BorderRadius.only(

                                            bottomRight: Radius.circular(12),

                                            bottomLeft: Radius.circular(12)

                                        )
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
                                      //  border: Border.all(color: Colors.redAccent,)

                                      // borderRadius: BorderRadius.circular(20),



                                    ),

                                    child: Text('Featured',style: TextStyle(color: Colors.white),),

                                  ),





                                ],

                              ),
                            ),
                            Text('or ',style: TextStyle(color: Colors.grey.shade700,fontSize: 18,fontWeight: FontWeight.w500
                            ),
                            ),
                            InkWell(
                              onTap: (){
                                setState(() {

                                  _pickAudiofile();
                                });
                              },
                              child: Column(

                                children: [



                                  Container(

                                    height: 48,

                                    width: 90,

                                    padding: EdgeInsets.all(13),

                                    decoration: BoxDecoration(

                                      // color: Colors.indigo,



                                        color: Colors.indigoAccent.shade400,

                                        //  border: Border.all(color: Colors.redAccent,)

                                        //  borderRadius: BorderRadius.circular(20),



                                        borderRadius: BorderRadius.only(

                                            topRight: Radius.circular(17),

                                            topLeft: Radius.circular(17)

                                        )

                                    ),

                                    child: Image.asset('images/device.png',color: Colors.white,),

                                  ),

                                  Container(

                                    height: 43,

                                    width: 90,

                                    alignment: Alignment.center,

                                    padding: EdgeInsets.all(13),

                                    decoration: BoxDecoration(

                                        color: Colors.black,


                                        borderRadius: BorderRadius.only(

                                            bottomRight: Radius.circular(12),

                                            bottomLeft: Radius.circular(12)

                                        )




                                    ),

                                    child: Text('My Music',style: TextStyle(color: Colors.white),),

                                  ),





                                ],

                              ),
                            ),

                          ],

                        ),
                      ),


                      SizedBox(height: 11,),


                    //  _filePath == null?
                      selectedFile == null?
                      Container():


                      Container(
                        height: 60,
                        width: 380,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Colors.indigo.shade50
                        ),
                        child: Row(
                          children: [SizedBox(width: 30,),
                            Lottie.asset('images/sound.json'),
                            Lottie.asset('images/sound.json'),
                            SizedBox(width: 46,),
                            InkWell(
                                onTap: (){
                                  setState(() {
                           //         _isPlaying? _stopAudio():_playAudio();
                                    playMusic();
                                  });
                                },
                                child:
                                _isPlaying?
                                Icon(Icons.pause_circle,color: Colors.indigoAccent.shade400,size: 40,):
                                Icon(Icons.play_circle,color: Colors.indigoAccent.shade400,size: 40,)

                            )
                          ],
                        ),
                      ),

                      SizedBox(height: 10,),
                      Text('Reminder Time ',style: TextStyle(color: Colors.grey.shade700,fontSize: 18,fontWeight: FontWeight.w500
                      ),
                      ),
                      SizedBox(height: 10,)
                      ,

                      InkWell(
                        onTap: (){
                          setState(() async {




_showBottomSheet(context);

Reference storageReference =
FirebaseStorage.instance.ref().child('imagepanellist/${DateTime.now()}.jpg');
UploadTask uploadTask = storageReference.putFile(_imageFile!);
TaskSnapshot storageTaskSnapshot = await uploadTask.whenComplete(() => null);
String downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();

FirebaseFirestore.instance.collection('mgreminders').add({





 // 'netwokimage':_selectedImageUrl,


//   'netwokimage':featuredimage == null ?"":featuredimage,

  'ReminderText': _textContoller.text,
  'imagefile':downloadUrl,
  'timestamp': Timestamp.now(),
 // 'audiofile': selectedFile!.path,

 // 'imagefile':
//_imageFile ==null ?  '':imagedownloadUrl ,

 // 'netwokimage':featuredimage,

 // 'time': _textEditingController.text,
//  'videofile':_videoFile !=null ? _videoFile!.path : _selectedVideoUrl


  // 'netwokimage':_selectedImageUrl,

});





                          });
                        },
                        child: Container(
                          height: 70,
                          width: 390,
                         alignment: Alignment.center
                         // padding: EdgeInsets.only(left: 30)
                          ,
                          decoration: BoxDecoration(
                              color: Colors.indigo.shade100,
                              borderRadius: BorderRadius.circular(9)
                          ),
                          child:  Text('60 mins',style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.w500
                          ),
                          ),

                        ),
                      ),

                      SizedBox(height: 10,),



                    ],
                  ),
                ),
              )
              ,

              Container(
                height: 50,
                width: 370,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(26),
                    color: Colors.indigoAccent
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('images/al.png',color: Colors.white,height: 25,),
                    SizedBox(width: 20,),
                    Text('Fill Required details, reminder will be added',style: TextStyle(color: Colors.white,fontSize: 15),)
                  ],
                ),
              ),



            ]
          ),
        ),

      ),


    );
  }
}

class VideoPlayerScreen extends StatefulWidget {
  final String videoUrl;

  VideoPlayerScreen(this.videoUrl);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  VideoPlayerController ? _controller;
  ChewieController ? _chewieController;
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl);
    _chewieController = ChewieController(
      videoPlayerController: _controller!,
      autoPlay: true,
      looping: true,
     fullScreenByDefault: true
     // aspectRatio:  0.4,
      // You can customize the UI with other options here
    );
  }

  @override
  void dispose() {
    _controller!.dispose();
    _chewieController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Your Video'),backgroundColor: Colors.indigoAccent.shade400,),
      body:  Container(
        height: double.infinity,
        width: double.infinity,
        child: Chewie(

            controller: _chewieController!),
      ),
    );
  }


}
