import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:posts_app_flutter/core/error/exceptions.dart';
import 'package:posts_app_flutter/features/posts/data/models/post_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PostsLocalDataSource {
  Future<List<PostModel>> getCachedPosts();
  Future<Unit> cachePosts(List<PostModel> posts);
}

class PostsLocalDataSourceImplementation implements PostsLocalDataSource {
  final SharedPreferences _sharedPreferences;

  PostsLocalDataSourceImplementation(
      {required SharedPreferences sharedPreferences})
      : _sharedPreferences = sharedPreferences;

  @override
  Future<Unit> cachePosts(List<PostModel> posts) {
    final List postsJson =
        posts.map<Map<String, dynamic>>((post) => post.toJson()).toList();
    _sharedPreferences.setString('posts', json.encode(postsJson));
    return Future.value(unit);
  }

  @override
  Future<List<PostModel>> getCachedPosts() {
    final jsonString = _sharedPreferences.getString('posts');
    if (jsonString != null) {
      final List postsJson = json.decode(jsonString);
      return Future.value(postsJson
          .map<PostModel>((post) => PostModel.fromJson(post))
          .toList());
    } else {
      throw EmptyCacheException();
    }
  }
}
