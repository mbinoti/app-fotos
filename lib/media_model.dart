class MediaModel {
  final String id;
  final String url;
  final FileType fileType;

  MediaModel({
    required this.id,
    required this.url,
    this.fileType = FileType.unknown,
  });
}

enum FileType { photo, video, unknown }
