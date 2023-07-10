import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final String imageUrl;
  final String tag;

  DetailScreen({required this.imageUrl, required this.tag});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Hero(
            tag: tag,
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
