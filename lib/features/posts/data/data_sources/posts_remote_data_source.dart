import 'package:dio/dio.dart';
import 'package:posts_app_flutter/features/posts/data/models/post_model.dart';
import 'package:posts_app_flutter/features/posts/domain/entities/post.dart';
import 'package:retrofit/retrofit.dart';
part 'posts_remote_data_source.g.dart';

@RestApi(baseUrl: 'https://jsonplaceholder.typicode.com')
abstract class PostsRemoteDataSource {
  factory PostsRemoteDataSource(Dio dio, {String baseUrl}) =
      _PostsRemoteDataSource;

  @GET('/posts')
  Future<List<PostModel>> getPosts();

  @POST('/posts')
  Future<void> createPost({@Body() required Post post});

  @PUT('/posts/{id}')
  Future<void> updatePost(
      {@Path('id') required int postId, @Body() required Post post});
      
  @DELETE('/posts/{id}')
  Future<void> deletePost({@Path('id') required int postId});
}
