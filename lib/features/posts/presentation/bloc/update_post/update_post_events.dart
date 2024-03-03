import 'package:equatable/equatable.dart';
import 'package:posts_app_flutter/features/posts/domain/entities/post.dart';

abstract class UpdatePostEvent extends Equatable {
  const UpdatePostEvent();

  @override
  List<Object> get props => [];
}

class UpdatePostButtonEvent extends UpdatePostEvent {
  final Post post;

  const UpdatePostButtonEvent(
      {required this.post});

  @override
  List<Object> get props => [post];
}