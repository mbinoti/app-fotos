import 'package:appvideo/firebase_media_repository.dart';
import 'package:appvideo/media_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:image_picker/image_picker.dart';
import 'dart:io';

class MediaController {
  final FirebaseMediaRepository _repository;
  final ImagePicker _picker = ImagePicker();

  MediaController(this._repository);

  Future<String?> captureAndUploadMedia() async {
    XFile? pickedFile;
    pickedFile = await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      File file = File(pickedFile.path); // Convert to File
      String downloadUrl = await _repository.uploadFile('assets/', file);

      // após uploading do arquivo, adiciona novo doc firestore
      await FirebaseFirestore.instance.collection('media').add({
        'url': downloadUrl,
        'id': pickedFile.name,
        // Add any other relevant metadata...
      });

      return downloadUrl;
    } else {
      print('No media selected.');
      return null;
    }
  }

  // Método para obter todas as mídias.
  Stream<List<MediaModel>> getAllMedia() {
    return FirebaseFirestore.instance
        .collection('media')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return MediaModel(
          url: doc['url'],
          id: doc['id'],
          // Map any other relevant metadata...
        );
      }).toList();
    });
  }

  Future<void> deleteMedia(MediaModel media) async {
    await _repository.deleteMedia('assets/', media);
  }
}
