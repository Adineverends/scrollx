import 'dart:io';

import 'dart:typed_data';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:uuid/uuid.dart';

class TextAudioreminderdata {
  final CollectionReference ref =
  FirebaseFirestore.instance.collection('textaudioreminder');
  Future<String> appSubscription(
      {
        required String ReminderText,

       required String imagefromdevice,
        required String featuredimage,
     //   required String time,

      }) async {
    String res = 'Some error ocurred';
    try {
      if (
          ReminderText.isNotEmpty ||
       imagefromdevice.isNotEmpty || featuredimage.isNotEmpty
              //time != null
            // ||

        //  file != null



      ) {




        //   String photourl = await StorageMethods()
        //        .uploadImageToStorage('CompanyLogoFile', file, false);





        await ref.add({
          'Remindertext':ReminderText,
         'imagefromdevice': imagefromdevice,
          'featuredimage':featuredimage,
        //  'time': time,

        });

        res = 'success';
      }
    } catch (e) {
      res = e.toString();
    }

    return res;
  }
}
