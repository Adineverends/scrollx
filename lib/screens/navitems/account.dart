import 'package:flutter/material.dart';

class account extends StatefulWidget {
  const account({Key? key}) : super(key: key);

  @override
  State<account> createState() => _accountState();
}

class _accountState extends State<account> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.grey.shade200,
/*
    body: Column(

    children: [

        Row(

        children: [

        InkWell(

        onTap: (){

      setState(() {



      });

    },



    child: Column(



    children: [







    Container(



    height: 120,



    width: 170,

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



    height: 50,



    width: 170,



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



    child: Text('Text',style: TextStyle(color: Colors.white),),



    ),











    ],



    ),

    ),

    SizedBox(width: 20,),

    InkWell(

    onTap: (){

    setState(() {



    });

    },



    child: Column(



    children: [







    Container(



    height: 120,



    width: 170,

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



    height: 50,



    width: 170,



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



    child: Text('Image + Text',style: TextStyle(color: Colors.white),),



    ),











    ],



    ),

    ),

    ],

    ),

    SizedBox(height: 15,),

    Row(

    children: [

    InkWell(

    onTap: (){

    setState(() {



    });

    },



    child: Column(



    children: [







    Container(



    height: 120,



    width: 170,

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



    height: 50,



    width: 170,



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



    child: Text('Image',style: TextStyle(color: Colors.white),),



    ),











    ],



    ),

    ),

    SizedBox(width: 20,),

    InkWell(

    onTap: (){

    setState(() {



    });

    },



    child: Column(



    children: [







    Container(



    height: 120,



    width: 170,

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



    height: 50,



    width: 170,



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



    child: Text('Video + Text',style: TextStyle(color: Colors.white),),



    ),











    ],



    ),

    ),

    ],

    ),

    SizedBox(height: 15,),

    Row(

    children: [

    InkWell(

    onTap: (){

    setState(() {



    });

    },



    child: Column(



    children: [







    Container(



    height: 120,



    width: 170,

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



    height: 50,



    width: 170,



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



    ],

    ),

    ],

    ),*/
        ),
        Container(
          height: 50,
          width: double.infinity,
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(left: 10,top: 10),
          decoration: BoxDecoration(
            color:  Colors.grey.shade200,
            // borderRadius: BorderRadius.only(topLeft: Radius.circular(20))
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Account',style: TextStyle(color: Colors.black,
                  fontWeight: FontWeight.bold,fontSize: 29
              ),),
              SizedBox(height: 3,),
              Container(
                height: 5,
                width: 40,
                decoration: BoxDecoration(
                    color: Colors.indigoAccent.shade400,
                    borderRadius: BorderRadius.circular(20)
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
