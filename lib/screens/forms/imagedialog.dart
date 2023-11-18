import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../featureditems/image.dart';
class imagedialog extends StatefulWidget {
  const imagedialog({Key? key}) : super(key: key);

  @override
  State<imagedialog> createState() => _imagedialogState();
}

class _imagedialogState extends State<imagedialog> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15,top: 8,right: 15),
      child: Column(
        mainAxisSize:MainAxisSize.min,
        children: [

          Container(
            height: 4,
            width: 55,
            decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(15)

            ),
          ),
          SizedBox(height: 20,),
          Text('Reminder Image ',style: TextStyle(color: Colors.grey.shade700,fontSize: 18,fontWeight: FontWeight.w500
          ),
          ),
          SizedBox(height: 20,),
          Row(

            mainAxisAlignment:MainAxisAlignment.center ,
            children: [
              InkWell(
                onTap: (){
                  setState(() {
                    Navigator.push(context, CupertinoPageRoute(
                        fullscreenDialog: true,
                        builder: (_)=>featuredimagelistpage ()));


                  });
                },

                child: Column(

                  children: [



                    Container(

                      height: 48,

                      width: 90,

                      padding: EdgeInsets.all(13),

                      decoration: BoxDecoration(

                          color: Colors.indigoAccent.shade400,








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
              SizedBox(width: 15,),
              Text('or ',style: TextStyle(color: Colors.grey.shade700,fontSize: 18,fontWeight: FontWeight.w500
              ),
              ),
              SizedBox(width: 15,),
              InkWell(
                onTap: (){
                  setState(() {
                //    selectButton('Button 1');
                   // _pickImageFromDevice();

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

                      child:Image.asset('images/device.png',color: Colors.white,),

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
        ],

      ),
    );
  }
}
