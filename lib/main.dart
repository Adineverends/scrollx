
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scrollx/screens/Overlay%20screens/text.dart';
import 'package:scrollx/screens/addedremindersinhome/textaudioreminder.dart';

import 'overlays/homepage.dart';
import 'overlays/messanger.dart';
import 'overlays/scrollx/alert message.dart';
import 'overlays/textfield.dart';
import 'screens/home.dart';

import 'overlays/truecaller.dart';
import 'package:file_picker/file_picker.dart' as file_picker;

import 'package:flutter/cupertino.dart';

void main() async {


  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

@pragma("vm:entry-point")
void overlayMain() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: textoverlay(remindertext: '', reminderudio: '', reminderimage: ''),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.indigoAccent.shade400, // set color for the status bar
      statusBarBrightness: Brightness.dark, // set brightness for the status bar text
    ));
    return const MaterialApp(
      debugShowCheckedModeBanner: false,

      home: home(),

    );
  }
}





class ImagePickerScreen extends StatefulWidget {
  @override
  _ImagePickerScreenState createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  File? _imageFile;
  String? _selectedImageUrl;

  Future<void> _pickImageFromDevice() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null && result.files.isNotEmpty) {
      setState(() {
        _imageFile = File(result.files.single.path!);
        _selectedImageUrl = null;
      });
    }
  }

  Future<void> _pickImageFromList() async {
    final snapshot = await FirebaseFirestore.instance.collection('imagelist').get();
    final urls = snapshot.docs.map((doc) => doc['image'] as String).toList();

    final result = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Select an image'),
        content: SingleChildScrollView(
          child: ListBody(
            children: urls
                .map((url) => ListTile(
              title: Text(url),
              onTap: () {
                Navigator.of(context).pop(url);
              },
            ))
                .toList(),
          ),
        ),
      ),
    );

    if (result != null) {
      setState(() {
        _imageFile = null;
        _selectedImageUrl = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_imageFile != null)
              SizedBox(
                height: 200,
                child: Image.file(_imageFile!),
              ),
            if (_selectedImageUrl != null)
              SizedBox(
                height: 200,
                child: Image.network(_selectedImageUrl!),
              ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _pickImageFromDevice,
                  child: Text('Pick from device'),
                ),
                ElevatedButton(
                  onPressed: _pickImageFromList,
                  child: Text('Pick from list'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}



class ReelsApp extends StatefulWidget {
  @override
  _ReelsAppState createState() => _ReelsAppState();
}

class _ReelsAppState extends State<ReelsApp> {
  final TextEditingController _reelTitleController = TextEditingController();
  final TextEditingController _reelCategoryController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String ? _uid;
  List<String> _categories = [];

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
    _getCategories();
  }

  void _getCurrentUser() {
    final User? user = _auth.currentUser;
    _uid = user!.uid;
  }

  void _getCategories() async {
    final QuerySnapshot snapshot = await _firestore.collection('categories').get();
    final List<dynamic> categories = snapshot.docs.map((doc) => doc['name']).toList();
    setState(() {
      _categories = categories.map((item) => item.toString()).toList();
    });
  }

  void _addReel() async {
    final String title = _reelTitleController.text.trim();
    final String category = _reelCategoryController.text.trim();
    if (title.isEmpty || category.isEmpty) return;
    final DocumentReference document =
    _firestore.collection('reels').doc();
    await document.set({
      'uid': _uid,
      'title': title,
      'category': category,
    });
    _reelTitleController.clear();
    _reelCategoryController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reels'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _reelTitleController,
              decoration: InputDecoration(
                labelText: 'Title',
              ),
            ),
            SizedBox(height: 8.0),
            TextField(
              controller: _reelCategoryController,
              decoration: InputDecoration(
                labelText: 'Category',
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _addReel,
                    child: Text('Save'),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Text(
              'Categories',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: 8.0),
            Wrap(
              spacing: 8.0,
              children: _categories
                  .map(
                    (category) => Chip(
                  label: Text(category),
                  backgroundColor: Colors.grey[200],
                ),
              )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}