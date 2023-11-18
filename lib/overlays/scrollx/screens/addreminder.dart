/*

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:scrollx/overlays/scrollx/screens/music.dart';
import 'package:scrollx/overlays/scrollx/screens/reminder%20page.dart';
import 'package:scrollx/overlays/scrollx/screens/videolist.dart';

import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../home.dart';
import 'image.dart';

class FormData {
  String text;
  String video;
  String image;
  String audio;

  FormData({
    required this.text,
    required this.video,
    required this.image,
    required this.audio,
  });
}

class reminder extends StatefulWidget {



   reminder({Key? key,}) : super(key: key);

  @override
  State<reminder> createState() => _reminderState();
}

class _reminderState extends State<reminder> {




int _currentpageindex=0;
  PageController _pageController = PageController(initialPage: 0);

  @override
  void dispose() {
    _pageController.dispose();
    _promptContoller.dispose();
    super.dispose();
  }

  void _goToNextPage() {
    if (_currentpageindex == 2) {
      // On the last page, change button text to "Submit"
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Form submitted'),
          content: Text('Thank you for submitting the form!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            )
          ],
        ),
      );
    } else {
      // Not on the last page, move to the next page
      _pageController.nextPage(duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
      setState(() {
        _currentpageindex++;
      });
    }
  }

void _goToPreviousPage() {
  if (_currentpageindex== 0) {
    return;
  } else {
    // Not on the first page, move to the previous page
    _pageController.previousPage(duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
    setState(() {
      _currentpageindex--;
    });
  }
}

String _textfieldvalue='';
String ? _imagePath;

void _submit() {
  Navigator.pop(context, _imagePath);
}


TextEditingController textFieldController = TextEditingController();
String ? selectedFile;

void _navigateToPickFileScreen() async {
  final pickedFile = await Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => imageoption()),
  );
  setState(() {
    selectedFile = pickedFile;
  });
}

void submit() {
  // code to submit data
  _pageController
      .jumpToPage(2);
}

void _submitAll() {
  // code to submit all collected data
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => reminderpage(),
  ));
}



TextEditingController _promptContoller=TextEditingController();

int _wordCount = 0;
String a='';
bool _showCancelIcon = false;

@override
void initState() {
  super.initState();
  _promptContoller= TextEditingController();


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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.black,
appBar: AppBar(
  backgroundColor: Colors.black,
  leading: IconButton(onPressed: (){

_goToPreviousPage();


  }, icon: Icon(Icons.arrow_back,color: Colors.white,)


  ),
  actions: [
    TextButton(onPressed: (){
      Navigator.pop(context);
    },
        child: Text('Exit',style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.w600),)

    )
  ],

),
      body: Column(
        children: [
          LinearProgressIndicator(
            value: (_currentpageindex + 1) / 3,
            backgroundColor: Colors.grey[300],
            color: Colors.redAccent,
            //valueColor: Colors.redAccent,
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (int index) {
                setState(() {
                  _currentpageindex = index;
                });
              },
              children: [
            Padding(padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Add Text To be displayed on ',style: TextStyle(color: Colors.white,fontSize: 45,fontWeight: FontWeight.bold),),
                  GradientText(
                    'Reminder',
                    style: TextStyle(
                        fontSize: 47.0,
                        fontWeight: FontWeight.bold
                    ),
                    colors: [
                      Colors.red,
                      Colors.pinkAccent,
                      Colors.red,
                    ],
                  ),

                  SizedBox(height: 30,),
                  Container(
                    height: _wordCount * 30.0 + 120.0,
                    width: 350,
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(left: 15,),
                    decoration: BoxDecoration(
                      //color: Colors.indigoAccent,
                        border: Border.all(color: Colors.grey,)
                        ,borderRadius: BorderRadius.circular(26)
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: TextField(
                            style: TextStyle(
                                color: Colors.white
                            ),
                          //  controller: widget.controller,
                            maxLines: 6,

                            onChanged: _wordCountChanged,
                            decoration: InputDecoration(

                              hintText: " Enter Your Text message for Reinder!",
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none,



                            ),
                            cursorColor: Colors.white,

                          ),
                        ),

                        Align(
                          alignment: Alignment.bottomRight,
                          child: IconButton(
                            icon: Icon(Icons.cancel,color: Colors.white,),
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
                  SizedBox(height: 260,),

                ],
              ),
            ),
          ),

page2(),

      Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Add Vedio or Image To be displayed on ',style: TextStyle(color: Colors.white,fontSize: 45,fontWeight: FontWeight.bold,letterSpacing: 1),),
              GradientText(
                'Reminder',
                style: TextStyle(
                    fontSize: 47.0,
                    fontWeight: FontWeight.bold
                ),
                colors: [
                  Colors.red,
                  Colors.pinkAccent,
                  Colors.red,
                ],
              ),

              SizedBox(height: 0,),
              Divider(color: Colors.white,),
              SizedBox(height: 20,),
              GradientText(
                'Select one of these',
                style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold
                ),
                colors: [
                  Colors.grey,
                  Colors.grey.shade300,
                  Colors.grey,
                ],
              ),
              SizedBox(height: 40,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (_)=>videoption()));
                    },
                    child: Column(
                      children: [
                        Image.asset('images/ve.png',height: 100,),
                        Text('Vedio',style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),),
                      ],
                    ),
                  ),
                  SizedBox(width: 60,),
                  InkWell(
                    onTap: () async{

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => imageoption()),
                      );


                    },
                    child: Column(
                      children: [
                        Image.asset('images/photo.png',height: 100),
                        Text('Image ',style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: 110,),

            ],
          ),
        ),
      )
              ],
            ),
          ),
          InkWell(
            onTap: (){
              setState(() {

               _goToNextPage();

              });
            },
            child: Container(
              width: 400,
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
                    _currentpageindex == 2 ? 'Submit' : 'Next',
                    style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.bold),
                  ),

                ],
              ),
            ),
          ),
          SizedBox(height: 20,)
        ],
      ),


    ));
  }
}



class page1 extends StatefulWidget {
  final TextEditingController controller;
  const page1({Key? key,required this.controller}) : super(key: key);

  @override
  State<page1> createState() => _page1State();
}

class _page1State extends State<page1> {
  TextEditingController _promptContoller=TextEditingController();

  int _wordCount = 0;
  String a='';
  bool _showCancelIcon = false;

  @override
  void initState() {
    super.initState();
    _promptContoller= TextEditingController();


  }

  @override
  void dispose() {
    _promptContoller.dispose();

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



  @override
  Widget build(BuildContext context) {
    return    Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Add Text To be displayed on ',style: TextStyle(color: Colors.white,fontSize: 45,fontWeight: FontWeight.bold),),
            GradientText(
              'Reminder',
              style: TextStyle(
                  fontSize: 47.0,
                  fontWeight: FontWeight.bold
              ),
              colors: [
                Colors.red,
                Colors.pinkAccent,
                Colors.red,
              ],
            ),

            SizedBox(height: 30,),
            Container(
              height: _wordCount * 30.0 + 120.0,
              width: 350,
              alignment: Alignment.center,
              padding: EdgeInsets.only(left: 15,),
              decoration: BoxDecoration(
                //color: Colors.indigoAccent,
                  border: Border.all(color: Colors.grey,)
                  ,borderRadius: BorderRadius.circular(26)
              ),
              child: Column(
                children: [
                  Expanded(
                    child: TextField(
                      style: TextStyle(
                          color: Colors.white
                      ),
                      controller: widget.controller,
                      maxLines: 6,

                      onChanged: _wordCountChanged,
                      decoration: InputDecoration(

                        hintText: " Enter Your Text message for Reinder!",
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none,



                      ),
                      cursorColor: Colors.white,

                    ),
                  ),

                  Align(
                    alignment: Alignment.bottomRight,
                    child: IconButton(
                      icon: Icon(Icons.cancel,color: Colors.white,),
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
            SizedBox(height: 260,),

          ],
        ),
      ),
    );
  }
}




class page2 extends StatefulWidget {


   page2({Key? key,}) : super(key: key);

  @override
  State<page2> createState() => _page2State();
}

class _page2State extends State<page2> {

  String? _filePath;

  void setFilePath(String filePath) {
    setState(() {
      _filePath = filePath;
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Add Vedio or Image To be displayed on ',style: TextStyle(color: Colors.white,fontSize: 45,fontWeight: FontWeight.bold,letterSpacing: 1),),
            GradientText(
              'Reminder',
              style: TextStyle(
                  fontSize: 47.0,
                  fontWeight: FontWeight.bold
              ),
              colors: [
                Colors.red,
                Colors.pinkAccent,
                Colors.red,
              ],
            ),

            SizedBox(height: 0,),
            Divider(color: Colors.white,),
            SizedBox(height: 20,),
            GradientText(
              'Select one of these',
              style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold
              ),
              colors: [
                Colors.grey,
                Colors.grey.shade300,
                Colors.grey,
              ],
            ),
            SizedBox(height: 40,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (_)=>videoption()));
                  },
                  child: Column(
                    children: [
                      Image.asset('images/ve.png',height: 100,),
                      Text('Vedio',style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),),
                    ],
                  ),
                ),
                SizedBox(width: 60,),
                InkWell(
                  onTap: () async{

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => imageoption()),
                    );


                  },
                  child: Column(
                    children: [
                      Image.asset('images/photo.png',height: 100),
                      Text('Image ',style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 110,),

          ],
        ),
      ),
    );
  }
}

class page3 extends StatefulWidget {
  final Function submitAll;
  const page3({Key? key,required this.submitAll}) : super(key: key);

  @override
  State<page3> createState() => _page3State();
}

class _page3State extends State<page3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Add Music or voice note to be displayed on ',style: TextStyle(color: Colors.white,fontSize: 45,fontWeight: FontWeight.bold),),
              GradientText(
                'Reminder',
                style: TextStyle(
                    fontSize: 47.0,
                    fontWeight: FontWeight.bold
                ),
                colors: [
                  Colors.red,
                  Colors.pinkAccent,
                  Colors.red,
                ],
              ),
              SizedBox(height: 20,),
              Center(
                  child: Image.asset('images/mu.png',height: 200)),
              SizedBox(height: 70,),

              InkWell(
                onTap: (){
                  setState(() {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_)=>music()));
                  });
                },
                child: Container(
                  width: 400,
                  height: 65,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: LinearGradient(
                          colors: [
                            Colors.indigo,
                            Colors.indigoAccent.shade200,
                            Colors.indigo
                          ]
                      )
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Choose Music or Voice note',
                        style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.bold),
                      ),

                    ],
                  ),
                ),
              ),
              //SizedBox(height: 15,),




            ],
          ),
        ),
      ),
    );
  }
}


*/
