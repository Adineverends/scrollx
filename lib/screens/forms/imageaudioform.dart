import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

class imageaudioform extends StatefulWidget {
  const imageaudioform({Key? key}) : super(key: key);

  @override
  State<imageaudioform> createState() => _imageaudioformState();
}

class _imageaudioformState extends State<imageaudioform> {


  TextEditingController _promptContoller=TextEditingController();

  int _wordCount = 0;
  String a='';
  bool _showCancelIcon = false;
  String ? selectedmusic;


  @override
  void initState() {
    super.initState();
    _promptContoller= TextEditingController();


  }

  @override
  void dispose() {
    _promptContoller.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }




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


      _promptContoller.clear();
      _wordCount = 0;

    });
  }




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















  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('Image Audio Form',style: TextStyle(color: Colors.white
          ),),
        ),
        body: Padding(
            padding: EdgeInsets.only(
                top: 10,left: 15,right: 15),
            child: CupertinoScrollbar(
              thickness: 7,
              radius: Radius.circular(12),
              isAlwaysShown: true,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [


                    SizedBox(height: 12,),
                    Text('Reminder Image ',style: TextStyle(color: Colors.black,fontSize: 23,fontWeight: FontWeight.bold
                    ),
                    ),
                    SizedBox(height: 12,),



                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 70),
                      child:   Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          InkWell(
                            onTap: (){
                              setState(() {

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

                                      //  borderRadius: BorderRadius.circular(20),



                                      borderRadius: BorderRadius.only(

                                          topRight: Radius.circular(17),

                                          topLeft: Radius.circular(17)

                                      )

                                  ),

                                  child: Icon(Icons.star),

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

                          InkWell(
                            onTap: (){
                              setState(() {
                                _pickAudioFile();
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

                                      //  borderRadius: BorderRadius.circular(20),



                                      borderRadius: BorderRadius.only(

                                          topRight: Radius.circular(17),

                                          topLeft: Radius.circular(17)

                                      )

                                  ),

                                  child: Image.asset('images/device.png'),

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

                                  child: Text('My Image',style: TextStyle(color: Colors.white),),

                                ),





                              ],

                            ),
                          ),
                        ],

                      ),
                    ),
                    SizedBox(height: 12,),
                    Text('Reminder Music ',style: TextStyle(color: Colors.black,fontSize: 23,fontWeight: FontWeight.bold
                    ),
                    ),
                    SizedBox(height: 12,),



                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 70),
                      child:   Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          InkWell(
                            onTap: (){
                              setState(() {

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

                                      //  borderRadius: BorderRadius.circular(20),



                                      borderRadius: BorderRadius.only(

                                          topRight: Radius.circular(17),

                                          topLeft: Radius.circular(17)

                                      )

                                  ),

                                  child: Icon(Icons.star),

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

                          InkWell(
                            onTap: (){
                              setState(() {
                                _pickAudioFile();
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

                                      //  borderRadius: BorderRadius.circular(20),



                                      borderRadius: BorderRadius.only(

                                          topRight: Radius.circular(17),

                                          topLeft: Radius.circular(17)

                                      )

                                  ),

                                  child: Image.asset('images/device.png'),

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

                                  child: Text('My Music',style: TextStyle(color: Colors.white),),

                                ),





                              ],

                            ),
                          ),
                        ],

                      ),
                    ),
                    SizedBox(height: 11,),
                    _filePath == null?
                    Container():
                    Container(
                      height: 60,
                      width: 380,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.black
                      ),
                      child: Row(
                        children: [SizedBox(width: 30,),
                          Lottie.asset('images/sound.json'),
                          Lottie.asset('images/sound.json'),
                          SizedBox(width: 46,),
                          InkWell(
                              onTap: (){
                                setState(() {
                                  _isPlaying?
                                  _stopAudio():_playAudio();
                                });
                              },
                              child:
                              _isPlaying?
                              Icon(Icons.pause_circle,color: Colors.white,size: 40,):
                              Icon(Icons.play_circle,color: Colors.white,size: 40,)

                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 10,),

                    InkWell(
                      onTap: (){
                        setState(() {

                        });
                      },
                      child: Container(
                        height: 60,
                        width: 380,
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color:
                            _promptContoller.text.isNotEmpty?
                            Colors.black:Colors.grey.shade400
                        ),
                        child: Row(
                          children: [
                            SizedBox(width: 110,),
                            Text('Add to home ',style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold
                            ),
                            ),
                            SizedBox(width: 80,),
                            InkWell(
                                onTap: (){
                                  setState(() {

                                  });
                                },
                                child: Icon(Icons.arrow_forward_ios,color: Colors.white,size: 26,)

                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
      ),
    );
  }
}
