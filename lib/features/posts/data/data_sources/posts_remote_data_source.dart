import 'package:dartz/dartz.dart';
import 'package:posts_app_flutter/features/posts/data/models/post_model.dart';
import 'package:posts_app_flutter/features/posts/domain/entities/post.dart';

abstract class PostsRemoteDataSource {
  Future<List<PostModel>> getPosts();
  Future<Unit> createPost({required Post post});
  Future<Unit> updatePost({required Post post});
  Future<Unit> deletePost({required int postId});
}

class PostsRemoteDataSourceImplementation implements PostsRemoteDataSource {
  @override
  Future<Unit> createPost({required Post post}) {
    // TODO: implement createPost
    throw UnimplementedError();
  }

  @override
  Future<Unit> deletePost({required int postId}) {
    // TODO: implement deletePost
    throw UnimplementedError();
  }

  @override
  Future<List<PostModel>> getPosts() {
    // TODO: implement getPosts
    throw UnimplementedError();
  }

  @override
  Future<Unit> updatePost({required Post post}) {
    // TODO: implement updatePost
    throw UnimplementedError();
  }
   
}
