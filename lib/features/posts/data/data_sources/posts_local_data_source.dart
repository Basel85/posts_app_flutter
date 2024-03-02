import 'package:dartz/dartz.dart';
import 'package:posts_app_flutter/features/posts/data/models/post_model.dart';

abstract class PostsLocalDataSource {
  Future<List<PostModel>> getCachedPosts();
  Future<Unit> cachePosts(List<PostModel> posts);
}

class PostsLocalDataSourceImplementation implements PostsLocalDataSource {
  final SharedPreferences _sharedPreferences;
  
  @override
  Future<Unit> cachePosts(List<PostModel> posts) {
    // TODO: implement cachePosts
    throw UnimplementedError();
  }

  @override
  Future<List<PostModel>> getCachedPosts() {
    // TODO: implement getCachedPosts
    throw UnimplementedError();
  }
  
}
