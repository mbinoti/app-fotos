class MediaModel {
  final String id;
  final String url;
  final MediaType type;

  MediaModel({required this.id, required this.url, required this.type});
}

enum MediaType { photo, video }
