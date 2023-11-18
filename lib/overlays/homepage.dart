import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    log("Started listening");
    FlutterOverlayWindow.overlayListener.listen((event) {
      log("$event");
    });
  }

  int? _totalSeconds;
  int? _secondsRemaining;
  Timer? _timer;
  final _minutesController = TextEditingController();

  void _startTimer() {
    _secondsRemaining = _totalSeconds;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining! > 0) {
          _secondsRemaining = _secondsRemaining! - 1;
          ;
        } else {
          _timer?.cancel();
          _showMessage();
        }
      });
    });
  }

  void _showMessage() async {
    if (await FlutterOverlayWindow.isActive()) return;
    await FlutterOverlayWindow.showOverlay(
    enableDrag: true,
    overlayTitle: "Scrollx",
    overlayContent: 'Overlay Enabled',
    flag: OverlayFlag.defaultFlag,
    alignment: OverlayAlignment.centerLeft,
    visibility: NotificationVisibility.visibilityPrivate,
    positionGravity: PositionGravity.auto,
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _minutesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
      appBar: AppBar(
        title: Text('Timer'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () async {
                final bool? res =
                await FlutterOverlayWindow.requestPermission();
                log("status: $res");
              },
              child: const Text("Request Permission"),
            ),
            TextField(
              controller: _minutesController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enter number of minutes',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                if (_minutesController.text.isNotEmpty) {
                  _totalSeconds = int.parse(_minutesController.text) * 60;
                  _startTimer();
                }
              },
              child: Text('Start Timer'),
            ),
            SizedBox(height: 16.0),
            _secondsRemaining == null
                ? Container()
                : Text(
              '${_secondsRemaining! ~/ 60} m ${_secondsRemaining! % 60} s',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 16.0),

          ],
        ),
      ),
    );
      /*
      Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: Center(
        child: Column(
          children: [
            TextButton(
              onPressed: () async {
                final status = await FlutterOverlayWindow.isPermissionGranted();
                log("Is Permission Granted: $status");
              },
              child: const Text("Check Permission"),
            ),
            const SizedBox(height: 10.0),
            TextButton(
              onPressed: () async {
                final bool? res =
                await FlutterOverlayWindow.requestPermission();
                log("status: $res");
              },
              child: const Text("Request Permission"),
            ),
            const SizedBox(height: 10.0),
            TextButton(
              onPressed: () async {
                if (await FlutterOverlayWindow.isActive()) return;
                await FlutterOverlayWindow.showOverlay(
                  enableDrag: true,
                  overlayTitle: "X-SLAYER",
                  overlayContent: 'Overlay Enabled',
                  flag: OverlayFlag.defaultFlag,
                  alignment: OverlayAlignment.centerLeft,
                  visibility: NotificationVisibility.visibilityPrivate,
                  positionGravity: PositionGravity.auto,
                );
              },
              child: const Text("Show Overlay"),
            ),
            const SizedBox(height: 10.0),
            TextButton(
              onPressed: () async {
                final status = await FlutterOverlayWindow.isActive();
                log("Is Active?: $status");
              },
              child: const Text("Is Active?"),
            ),
            const SizedBox(height: 10.0),
            TextButton(
              onPressed: () async {
                await FlutterOverlayWindow.shareData('update');
              },
              child: const Text("Update Overlay"),
            ),
            const SizedBox(height: 10.0),
            TextButton(
              onPressed: () {
                log('Try to close');
                FlutterOverlayWindow.closeOverlay()
                    .then((value) => log('STOPPED: alue: $value'));
              },
              child: const Text("Close Overlay"),
            ),
          ],
        ),
      ),
    );*/
  }
}