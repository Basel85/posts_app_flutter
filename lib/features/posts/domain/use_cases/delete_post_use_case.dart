import 'package:dartz/dartz.dart';
import 'package:posts_app_flutter/core/network_exceptions/network_exceptions.dart';
import 'package:posts_app_flutter/features/posts/domain/repositories/posts_repository.dart';

class DeletePostUseCase {
  final PostsRepository _postRepository;

  DeletePostUseCase(this._postRepository);

  Future<Either<NetworkExceptions,void>> call({required int postId}) async {
    return await _postRepository.deletePost(postId: postId);
  }
}