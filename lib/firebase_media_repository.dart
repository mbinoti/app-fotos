import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

import 'package:path/path.dart';

class FirebaseMediaRepository {
  final FirebaseStorage _firebaseStorage;

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
}
