import 'dart:convert';

class SyllabusModel {
  final int? id;
  final String title;
  final String contentJson;

  SyllabusModel({this.id, required this.title, required this.contentJson});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'content_json': contentJson,
    };
  }

  factory SyllabusModel.fromMap(Map<String, dynamic> map) {
    return SyllabusModel(
      id: map['id'],
      title: map['title'],
      contentJson: map['content_json'],
    );
  }
}
