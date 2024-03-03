import 'package:dartz/dartz.dart';
import 'package:posts_app_flutter/core/network_exceptions/network_exceptions.dart';
import 'package:posts_app_flutter/features/posts/domain/entities/post.dart';
import 'package:posts_app_flutter/features/posts/domain/repositories/posts_repository.dart';

class UpdatePostUseCase {
  final PostsRepository _postRepository;

  UpdatePostUseCase(this._postRepository);

  Future<Either<NetworkExceptions, void>> call({required Post post}) async {
    return await _postRepository.updatePost(post: post);
  }
}
