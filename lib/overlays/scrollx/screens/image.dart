/*
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:scrollx/overlays/scrollx/screens/addreminder.dart';


import 'package:simple_gradient_text/simple_gradient_text.dart';












class imageoption extends StatefulWidget {


   imageoption({Key? key,}) : super(key: key);

  @override
  State<imageoption> createState() => _imageoptionState();
}

class _imageoptionState extends State<imageoption> {


  List<String> _imageList = [];

  Future<List<String>> _fetchImageList() async {
    List<String> imageList = [];

    try {
      // initialize Firebase Storage instance
      FirebaseStorage storage = FirebaseStorage.instance;

      // get image folder reference from Firebase Storage
      Reference imageFolderRef = storage.ref().child('uploads');

      // get all image files inside the image folder
      ListResult imageFiles = await imageFolderRef.listAll();

      // loop through all image files and add their download URLs to imageList
      for (var imageFile in imageFiles.items) {
        String imageUrl = await imageFile.getDownloadURL();
        imageList.add(imageUrl);
      }
    } catch (e) {
      print('Error fetching image list: $e');
    }

    return imageList;
  }


  File? _imageFile;
  bool _isUploading = false;

  void _pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );
    if (result != null) {
      setState(() {
        _imageFile = File(result.files.single.path!);
      });
    }
  }

  void _uploadImage() async {
    setState(() {
      _isUploading = true;
    });

    FirebaseStorage storage = FirebaseStorage.instance;
    Reference storageReference = storage.ref().child('images/${_imageFile!.path.split('/').last}');
    UploadTask uploadTask = storageReference.putFile(_imageFile!);
    await uploadTask.whenComplete(() =>
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Image Submitted'))
        )
    );
    setState(() {
      _isUploading = false;
    });
  }
  String ? _imagePath;







  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('Images',style: TextStyle(color: Colors.white),),
          bottom: TabBar(
              dividerColor: Colors.redAccent,
              // labelColor: Colors.redAccent,
              indicatorColor: Colors.redAccent,
              tabs: [
                Tab(
                  text: 'FEATURED',


                ),
                Tab(text: 'My Images'),

              ]),
        ),
        body: TabBarView(
          children: [
            Center(
              child: FutureBuilder<List<String>>(
                future: _fetchImageList(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    _imageList = snapshot.data!;
                    return SizedBox(
                      height: 600,
                      child: CardSwiper(
                        cards: _imageList.map((imageUrl) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                image: NetworkImage(imageUrl),
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        }).toList(),

                      ),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
    Padding(
    padding: const EdgeInsets.only(left: 30,top: 20,right: 30),
    child: SingleChildScrollView(
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Text('Choose Your  ',style: TextStyle(color: Colors.white,fontSize: 37,fontWeight: FontWeight.bold,letterSpacing: 2),),
    GradientText(
    'Image',
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

    _imageFile == null?
    Column(
    children: [
    InkWell(
    onTap: (){
    _pickImage();
    },
    child: Column(
    children: [
    Image.asset('images/cam.png'),
    Text('Click here ',style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.w500,letterSpacing: 2),),
    ],
    )),

    ],
    ):Column(
    children: [
    ClipRRect(
    borderRadius: BorderRadius.circular(20),
    child: Image.file(_imageFile!)),

    SizedBox(height: 16,),

    InkWell(
    onTap: (){
    setState(() {


    _pickImage();



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
    ),
    SizedBox(height: 56,),


    InkWell(
    onTap: (){
    setState(() async {



    //  _isUploading ? null : _uploadImage();

    Navigator.pop(context, _imagePath);

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
    )

          ],
        ),
      ),
    );
  }
}






class images extends StatefulWidget {

   images({Key? key,}) : super(key: key);

  @override
  State<images> createState() => _imagesState();
}

class _imagesState extends State<images> {
/*
  List<String> _audioList = [];
  Future<List<String>> _fetchAudioList() async {
    List<String> audioList = [];
    try {
      // initialize Firebase Storage instance
      FirebaseStorage storage = FirebaseStorage.instance;

      // get audio folder reference from Firebase Storage
      Reference audioFolderRef = storage.ref().child('uploads');

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


*/

  List<String> _imageList = [];

  Future<List<String>> _fetchImageList() async {
    List<String> imageList = [];

    try {
      // initialize Firebase Storage instance
      FirebaseStorage storage = FirebaseStorage.instance;

      // get image folder reference from Firebase Storage
      Reference imageFolderRef = storage.ref().child('uploads');

      // get all image files inside the image folder
      ListResult imageFiles = await imageFolderRef.listAll();

      // loop through all image files and add their download URLs to imageList
      for (var imageFile in imageFiles.items) {
        String imageUrl = await imageFile.getDownloadURL();
        imageList.add(imageUrl);
      }
    } catch (e) {
      print('Error fetching image list: $e');
    }

    return imageList;
  }









  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Colors.black,








      body: Center(
        child: FutureBuilder<List<String>>(
          future: _fetchImageList(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              _imageList = snapshot.data!;
              return SizedBox(
                height: 600,
                child: CardSwiper(
                  cards: _imageList.map((imageUrl) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: NetworkImage(imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  }).toList(), cardBuilder: (BuildContext context, int index) {  },

                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),


    );
  }






}


class pickimage extends StatefulWidget {
  const pickimage({Key? key}) : super(key: key);

  @override
  State<pickimage> createState() => _pickimageState();
}

class _pickimageState extends State<pickimage> {


  File? _imageFile;
  bool _isUploading = false;

  void _pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );
    if (result != null) {
      setState(() {
        _imageFile = File(result.files.single.path!);
      });
    }
  }

  void _uploadImage() async {
    setState(() {
      _isUploading = true;
    });

    FirebaseStorage storage = FirebaseStorage.instance;
    Reference storageReference = storage.ref().child('images/${_imageFile!.path.split('/').last}');
    UploadTask uploadTask = storageReference.putFile(_imageFile!);
    await uploadTask.whenComplete(() => 
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Image Submitted'))
    )
    );
    setState(() {
      _isUploading = false;
    });
  }
  String ? _imagePath;





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
              'Image',
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

            _imageFile == null?
            Column(
              children: [
                InkWell(
                    onTap: (){
_pickImage();
                    },
                    child: Column(
                      children: [
                        Image.asset('images/cam.png'),
                        Text('Click here ',style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.w500,letterSpacing: 2),),
                      ],
                    )),

              ],
            ):Column(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.file(_imageFile!)),

                SizedBox(height: 16,),

                InkWell(
                  onTap: (){
                    setState(() {


_pickImage();



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
            ),
           SizedBox(height: 56,),


            InkWell(
              onTap: (){
                setState(() async {



                //  _isUploading ? null : _uploadImage();

                    Navigator.pop(context, _imagePath);

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
*/