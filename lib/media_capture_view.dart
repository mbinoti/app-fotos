import 'package:appvideo/media_controller.dart';
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
              String? downloadUrl =
                  await _controller.captureAndUploadMedia(MediaType.photo);
              if (downloadUrl != null) {
                print('Photo uploaded: $downloadUrl');
              }
            },
            child: const Text('Capture Photo'),
          ),
          ElevatedButton(
            onPressed: () async {
              String? downloadUrl =
                  await _controller.captureAndUploadMedia(MediaType.video);
              if (downloadUrl != null) {
                print('Video uploaded: $downloadUrl');
              }
            },
            child: const Text('Capture Video'),
          ),
        ],
      ),
    );
  }
}
