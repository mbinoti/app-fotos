import 'package:appvideo/media_model.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  final ValueNotifier<List<MediaModel>> mediaListNotifier;

  HomeView(this.mediaListNotifier);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Media Grid')),
      body: ValueListenableBuilder<List<MediaModel>>(
        valueListenable: mediaListNotifier,
        builder: (context, mediaList, child) {
          return GridView.builder(
            itemCount: mediaList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Adjust to fit your needs
            ),
            itemBuilder: (context, index) {
              MediaModel media = mediaList[index];
              return GridTile(
                footer: Container(
                  color: Colors.black54,
                  child: ListTile(
                    title: Text(
                      '${media.id}',
                      style: const TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      'Video',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                child: Image.network(media.url),
              );
            },
          );
        },
      ),
    );
  }
}
