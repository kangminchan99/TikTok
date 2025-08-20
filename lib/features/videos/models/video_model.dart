class VideoModel {
  final String fileUrl;
  final String title;
  final String description;
  final String thumbnailUrl;
  final int likes;
  final int comments;
  final String creator;
  final String creatorUid;
  final int createdAt;

  VideoModel({
    required this.title,
    required this.fileUrl,
    required this.thumbnailUrl,
    required this.likes,
    required this.comments,
    required this.creator,
    required this.description,
    required this.creatorUid,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'fileUrl': fileUrl,
      'thumbnailUrl': thumbnailUrl,
      'likes': likes,
      'comments': comments,
      'creator': creator,
      'description': description,
      'creatorUid': creatorUid,
      'createdAt': createdAt,
    };
  }
}
