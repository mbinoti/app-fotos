import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:appvideo/media_controller.dart';
import 'package:appvideo/media_model.dart';
import 'package:flutter_video_info/flutter_video_info.dart';

class MediaGridView extends StatelessWidget {
  final MediaController _controller;

  MediaGridView(this._controller);

  final videoInfo = FlutterVideoInfo();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Media Grid View'),
        actions: [
          IconButton(
            icon: const Icon(Icons.photo),
            onPressed: () async {
              String? downloadUrl = await _controller.captureAndUploadMedia();
              _controller.getAllMedia();
              // if (downloadUrl != null) {
              //   print('Photo uploaded: $downloadUrl');
              // }
            },
          ),
        ],
      ),
      body: StreamBuilder<List<MediaModel>>(
        stream: _controller.getAllMedia(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }
          // List<MediaModel> mediaList = snapshot.data!;//
          return GridView.builder(
            itemCount: snapshot.data!.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemBuilder: (BuildContext context, index) {
              MediaModel media = snapshot.data![index]; //

              return Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: CachedNetworkImage(
                        imageUrl: media.url,
                        fit: BoxFit.cover,
                        // placeholder: (context, url) =>
                        //     const CircularProgressIndicator(),
                        // errorWidget: (context, url, error) =>
                        //     const Icon(Icons.error),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
