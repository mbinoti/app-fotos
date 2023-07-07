import 'package:appvideo/media_controller.dart';
import 'package:appvideo/media_grid_view.dart';
import 'package:appvideo/media_model.dart';
import 'package:flutter/material.dart';

class MediaCaptureView extends StatelessWidget {
  final MediaController _controller;

  MediaCaptureView(this._controller);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              String? downloadUrl = await _controller.captureAndUploadMedia();
              if (downloadUrl != null) {
                print('Photo uploaded: $downloadUrl');
              }
            },
            child: const Text('Capture Photo'),
          ),
          ElevatedButton(
            onPressed: () async {
              String? downloadUrl = await _controller.captureAndUploadMedia();
              if (downloadUrl != null) {
                print('Video uploaded: $downloadUrl');
              }
            },
            child: const Text('Capture Video'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MediaGridView(_controller)),
              );
            },
            child: const Text('View Media'),
          )
        ],
      ),
    );
  }
}
