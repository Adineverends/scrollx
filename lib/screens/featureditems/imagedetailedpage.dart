import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scrollx/screens/forms/textaudioform.dart';

class imagedetailedpage extends StatefulWidget {
  String imageurl;
  bool isfree;
   imagedetailedpage({Key? key,required this.imageurl,required this.isfree}) : super(key: key);

  @override
  State<imagedetailedpage> createState() => _imagedetailedpageState();
}

class _imagedetailedpageState extends State<imagedetailedpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigoAccent,
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent,
        elevation: 0,
        title: Text('Select Your  Image'),
      ),

     body: Padding(
       padding: const EdgeInsets.only(top: 30,left: 15,right: 15),
       child: Column(
         children: [
           Container(
             height: 570,
             //         width: 500,
             padding: EdgeInsets.all(8),
             alignment: Alignment.topRight,
             decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(15),
                 image: DecorationImage(
                     image: NetworkImage(widget.imageurl),
                     fit: BoxFit.cover
                 )
             ),
            // child: widget.isfree ? Icon(Icons.lock_open):Icon(Icons.lock),
           ),

         ],
       ),
     ),
      bottomNavigationBar:InkWell(
        onTap: (){
          setState(() {
            Navigator.pushReplacement(context, CupertinoPageRoute(
                fullscreenDialog: true,
                builder: (_)=> textaudioform(featuredfilepath: '', featuredimagepath: widget.imageurl)));
          });
        },
        child: Container(
          height: 70,
          width: 500,
          margin: EdgeInsets.all(8),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black
          ),
          // child: widget.isfree ? Icon(Icons.lock_open):Icon(Icons.lock),
          child: Text('SELECT IMAGE',style: TextStyle(color: Colors.white),),
        ),
      ),
    );
  }
}
