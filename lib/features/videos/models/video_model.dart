class VideoModel {
  final String id;
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
    required this.id,
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

  VideoModel.fromJson({
    required Map<String, dynamic> json,
    required String videoId,
  }) : id = videoId,
       title = json['title'],
       fileUrl = json['fileUrl'],
       thumbnailUrl = json['thumbnailUrl'],
       likes = json['likes'],
       comments = json['comments'],
       creator = json['creator'],
       description = json['description'],
       creatorUid = json['creatorUid'],
       createdAt = json['createdAt'];

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
