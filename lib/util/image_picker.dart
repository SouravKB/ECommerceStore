import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImageChooser {
  ImageChooser._();

  // Used only if you need a single picture
  Future getImage(bool gallery) async {
    ImagePicker picker = ImagePicker();
    XFile? pickedFile;
    // Let user select photo from gallery
    if (gallery) {
      pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        maxHeight: 1800,
        maxWidth: 1800,
      );
    }
    // Otherwise open camera to get new photo
    else {
      pickedFile = await picker.pickImage(
        source: ImageSource.camera,
        maxHeight: 1800,
        maxWidth: 1800,
      );
    }
    if (pickedFile != null) {
      return File(pickedFile.path);
    } else {
      return null;
    }
  }

  static final instance = ImageChooser._();
}
