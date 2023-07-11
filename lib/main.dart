import 'package:appvideo/firebase_media_repository.dart';
import 'package:appvideo/media_controller.dart';
import 'package:appvideo/media_grid_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final FirebaseMediaRepository _repository;
  final MediaController _controller;

  MyApp()
      : _repository = FirebaseMediaRepository(FirebaseStorage.instance),
        _controller =
            MediaController(FirebaseMediaRepository(FirebaseStorage.instance));

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: MediaGridView(_controller),
      ),
    );
  }
}
