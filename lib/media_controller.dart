import 'package:appvideo/firebase_media_repository.dart';
import 'package:appvideo/media_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class MediaController {
  final FirebaseMediaRepository _repository;
  final ImagePicker _picker = ImagePicker();

  MediaController(this._repository);

  // ValueNotifier variable
  // ValueNotifier<List<MediaModel>> mediaList =
  //     ValueNotifier<List<MediaModel>>([]);

  Future<String?> captureAndUploadMedia() async {
    XFile? pickedFile;
    pickedFile = await _picker.pickVideo(source: ImageSource.camera);

    if (pickedFile != null) {
      File file = File(pickedFile.path); // Convert to File
      String downloadUrl = await _repository.uploadFile('assets/', file);
      return downloadUrl;
    } else {
      print('No media selected.');
      return null;
    }
  }

  // Método para obter todas as mídias
  Stream<List<MediaModel>> getAllMedia() {
    return _repository.getAllMedia('assets/');
  }
}
