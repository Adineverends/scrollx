import 'package:flutter/material.dart';

class buypremiumpage extends StatefulWidget {
  const buypremiumpage({Key? key}) : super(key: key);

  @override
  State<buypremiumpage> createState() => _buypremiumpageState();
}

class _buypremiumpageState extends State<buypremiumpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigoAccent,
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent,
        elevation: 0,
        title: Text('Buy Premium'),
      ),
    );
  }
}
