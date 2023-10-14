import 'dart:io';

import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart';

class FirabaseStorageClient {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future<String> uploadAvatars(File file, String folder) async {
    final storageRef =
        _firebaseStorage.ref().child(folder).child('/${file.path}');
    try {
      await storageRef.putFile(file);
      return await storageRef.getDownloadURL();
    } on firebase_core.FirebaseException {
      // rethrow the error because we want to catch the
      // error in data repository, remember we treat
      // repository as DAO
      rethrow;
    }
  }
}
