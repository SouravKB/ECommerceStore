
import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class ImageStoring{
  ImageStoring._();

  static final instance=ImageStoring._();

  // Used only if you need a single picture

  Future getImage(bool gallery) async {
    ImagePicker picker = ImagePicker();
    XFile? pickedFile;
    // Let user select photo from gallery
    if(gallery) {
      pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        maxHeight: 1800,
        maxWidth: 1800,
      );
    }
    // Otherwise open camera to get new photo
    else{
      pickedFile = await picker.pickImage(
        source: ImageSource.camera,
        maxHeight: 1800,
        maxWidth: 1800,
      );
    }
      if (pickedFile != null) {
        return File(pickedFile.path); // Use if you only need a single picture
      } else {
        return null;
      }
  }

  Future<String> uploadFile(File image,String path) async {
    String fileName = basename(image.path);
    log('start');
    Reference reference = FirebaseStorage.instance
        .ref()
        .child('$path/$fileName}');
    log(reference.toString());
    UploadTask uploadTask = reference.putFile(image);
    uploadTask.catchError((e) {
      log(e.toString());
    });
    await uploadTask.whenComplete(() => print('File Uploaded'));
    String _returnUrl;
    _returnUrl= await reference.getDownloadURL();
    return _returnUrl;
  }
}