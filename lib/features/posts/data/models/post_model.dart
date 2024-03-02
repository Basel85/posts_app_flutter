import 'package:posts_app_flutter/features/posts/domain/entities/post.dart';

class PostModel extends Post {
  const PostModel({int? id, required String title, required String body})
      : super(id: id, title: title, body: body);

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      title: json['title'],
      body: json['body'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['body'] = body;
    return data;
  }
}
