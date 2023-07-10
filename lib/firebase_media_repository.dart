import 'dart:async';
import 'dart:io';

import 'package:appvideo/media_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:path/path.dart';

class FirebaseMediaRepository {
  final FirebaseStorage _firebaseStorage;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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

  Future<void> deleteMedia(String path, MediaModel media) async {
    // deletar o documento do firestore.
    // Recuperar a referência do documento pelo 'id'
    QuerySnapshot snapshot = await _firestore
        .collection('media')
        .where('id', isEqualTo: media.id)
        .get();

    // Assume que só tem um documento que corresponde
    if (snapshot.docs.isNotEmpty) {
      DocumentSnapshot document = snapshot.docs.first;

      // Deletar o arquivo do Firebase Storage primeiro.
      print('Deletando o arquivo: $path${media.id}');
      final ref = _firebaseStorage.ref().child('$path${media.id}');
      await ref.delete();

      // Deletar o documento do Firestore
      await document.reference.delete();
    }
  }
}
