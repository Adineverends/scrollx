import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
class imageoverlay extends StatefulWidget {
  const imageoverlay({Key? key}) : super(key: key);

  @override
  State<imageoverlay> createState() => _imageoverlayState();
}

class _imageoverlayState extends State<imageoverlay> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Container(
          height: 284,
          width: 400,
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
              // borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                  image: AssetImage('images/qut.jpg'),
                  fit: BoxFit.cover
              ),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(17),
                  topLeft: Radius.circular(17)
              )
          ),

        ),

        Container(
          height: 50,
          width: 400,
          decoration: BoxDecoration(
              color: Colors.white,
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

              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(17),
                  bottomLeft: Radius.circular(17)
              )
          ),
          child: Row(
            children: [
              Lottie.asset('images/sound.json',),
              Lottie.asset('images/sound.json',),
              SizedBox(width: 30,),
              Image.asset('images/adds.png',)
            ],
          ),
        ),

      ],
    );
  }
}
