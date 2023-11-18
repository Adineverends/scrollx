import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
class imagetextoverlay extends StatefulWidget {
  const imagetextoverlay({Key? key}) : super(key: key);

  @override
  State<imagetextoverlay> createState() => _imagetextoverlayState();
}

class _imagetextoverlayState extends State<imagetextoverlay> {
  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [

        Container(
          height: 264,
          width: 400,
          padding: EdgeInsets.all(13),
          decoration: const BoxDecoration(
            // color: Colors.indigo,

            //      color: Colors.indigoAccent.shade400,
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
          height: 114,
          width: 400,
          padding: EdgeInsets.all(13),
          decoration: BoxDecoration(
            // color: Colors.indigo,

            color: Colors.indigoAccent.shade400,
            //  border: Border.all(color: Colors.redAccent,)
            // borderRadius: BorderRadius.circular(20),

          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Stop Scrolling you  \nhave your exam',style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold
              ),
              ),
              //
              //  Divider(),
              /*
                            Padding(
                              padding: const EdgeInsets.only(top: 17,left: 40),
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: IconButton(
                                  icon: Icon(Icons.cancel,color: Colors.white,),
                                  onPressed: (){},

                                ),
                              ),
                            ),
*/


            ],
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
