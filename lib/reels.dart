import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
    final User ? user = _auth.currentUser;
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