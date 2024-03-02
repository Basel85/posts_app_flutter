import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:posts_app_flutter/core/end_points/api_end_points.dart';
import 'package:posts_app_flutter/core/error/exceptions.dart';
import 'package:posts_app_flutter/features/posts/data/models/post_model.dart';
import 'package:posts_app_flutter/features/posts/domain/entities/post.dart';

abstract class PostsRemoteDataSource {
  Future<List<PostModel>> getPosts();
  Future<Unit> createPost({required Post post});
  Future<Unit> updatePost({required Post post});
  Future<Unit> deletePost({required int postId});
}

class PostsRemoteDataSourceImplementation implements PostsRemoteDataSource {
  final Dio _dio;

  PostsRemoteDataSourceImplementation({required Dio dio}) : _dio = dio;

  @override
  Future<Unit> createPost({required Post post}) async {
    final body = {
      'title': post.title,
      'body': post.body,
    };
    final response =
        await _dio.post(ApiEndPoints.baseUrl + ApiEndPoints.posts, data: body);
    if (response.statusCode == 201) {
      return unit;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deletePost({required int postId}) async {
    final response = await _dio
        .delete('${ApiEndPoints.baseUrl}${ApiEndPoints.posts}/$postId');
    if (response.statusCode == 200) {
      return unit;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<PostModel>> getPosts() async {
    final response = await _dio.get(ApiEndPoints.baseUrl + ApiEndPoints.posts);
    if (response.statusCode == 200) {
      final List<PostModel> posts =
          (response.data as List<Map<String, dynamic>>)
              .map<PostModel>((post) => PostModel.fromJson(post))
              .toList();
      return posts;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updatePost({required Post post}) async {
    final body = {
      'title': post.title,
      'body': post.body,
    };
    final response = await _dio.put(
        '${ApiEndPoints.baseUrl}${ApiEndPoints.posts}/${post.id}',
        data: body);
    if (response.statusCode == 200) {
      return unit;
    } else {
      throw ServerException();
    }
  }
}
