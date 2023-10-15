import 'dart:io';

import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart';

class FirabaseStorageClient {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future<String> uploadAvatars(File file, String folder) async {
    final fileName = _concatenateUntilSlash(file.path);
    final storageRef = _firebaseStorage.ref().child(folder).child('/$fileName');
    try {
      await storageRef.putFile(file);
      return await storageRef.getDownloadURL();
    } on firebase_core.FirebaseException {
      // rethrow the error because we want to catch the
      // error in data repository, remember we treat
      // our repository as DAO
      rethrow;
    }
  }

  String _concatenateUntilSlash(String input) {
    String result = '';

    for (int i = input.length - 1; i >= 0; i--) {
      if (input[i] == '/') {
        break; // Stop when '/' is found
      }
      result = input[i] +
          result; // Concatenate character to the beginning of the result
    }

    return result;
  }
}
