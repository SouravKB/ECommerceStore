import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class StorageService {
  StorageService._();

  static final _storage = FirebaseStorage.instance;

  Future<String> uploadFile(File image, String path) async {
    String fileName = basename(image.path);
    Reference reference = _storage.ref().child(path).child(fileName);
    await reference.putFile(image);
    return await reference.getDownloadURL();
  }

  static final instance = StorageService._();
}
