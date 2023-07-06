import 'package:appvideo/firebase_media_repository.dart';
import 'package:appvideo/media_model.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class MediaController {
  final FirebaseMediaRepository _repository;
  final ImagePicker _picker = ImagePicker();

  MediaController(this._repository);

  Future<String?> captureAndUploadMedia(MediaType type) async {
    XFile? pickedFile;
    if (type == MediaType.photo) {
      pickedFile = await _picker.pickImage(source: ImageSource.camera);
    } else {
      pickedFile = await _picker.pickVideo(source: ImageSource.camera);
    }

    if (pickedFile != null) {
      File file = File(pickedFile.path); // Convert to File
      String downloadUrl = await _repository.uploadFile('assets/', file);
      return downloadUrl;
    } else {
      print('No media selected.');
      return null;
    }
  }
}
