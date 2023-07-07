import 'dart:async';
import 'dart:io';

import 'package:appvideo/media_model.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:path/path.dart';

class FirebaseMediaRepository {
  final FirebaseStorage _firebaseStorage;
  // final StreamController<List<MediaModel>> _mediaStreamController =
  //     StreamController<List<MediaModel>>();

  FirebaseMediaRepository(this._firebaseStorage);

  Future<String> uploadFile(String path, File file) async {
    // Obter apenas o nome do arquivo
    String fileName = basename(file.path);

    final ref = _firebaseStorage.ref().child('$path$fileName');
    // final ref = _firebaseStorage.ref().child('minha_pasta/$fileName');

    final uploadTask = ref.putFile(file);
    final snapshot = await uploadTask.whenComplete(() => {});
    return await snapshot.ref.getDownloadURL();
  }

  // download
  // download
  Stream<List<MediaModel>> getAllMedia(String path) async* {
    final ref = _firebaseStorage.ref().child(path);
    List<MediaModel> mediaList = [];

    final ListResult result = await ref.listAll();

    for (var item in result.items) {
      String downloadUrl = await item.getDownloadURL();
      String extension = item.name.split('.').last;

      FileType fileType;
      if (extension.toLowerCase() == 'jpg' ||
          extension.toLowerCase() == 'png') {
        fileType = FileType.photo;
      } else if (extension.toLowerCase() == 'mp4') {
        fileType = FileType.video;
      } else {
        fileType = FileType.unknown;
      }

      mediaList
          .add(MediaModel(url: downloadUrl, id: item.name, fileType: fileType));
    }

    yield mediaList;
  }
}
