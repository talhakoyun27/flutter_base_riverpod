import 'dart:convert';

class PostModel {
  final int? id;
  final String? imageUrl;
  String? title;
  String? description;
  bool? isSaved;
  final String? url;

  PostModel({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.description,
    this.isSaved,
    this.url,
  });

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      id: map['id'],
      title: map['title'],
      imageUrl: map['imageUrl'],
      description: map['description'],
      isSaved: map['isSaved'],
      url: map['url'],
    );
  }

  factory PostModel.fromJson(String source) =>
      PostModel.fromMap(json.decode(source));

  void toggleSave({bool? value}) {
    isSaved = value ?? !(isSaved ?? true);
  }
}
