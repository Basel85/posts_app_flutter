import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app_flutter/core/network_exceptions/network_exceptions.dart';
import 'package:posts_app_flutter/features/posts/domain/use_cases/get_all_posts_use_case.dart';
import 'package:posts_app_flutter/features/posts/presentation/bloc/posts/posts_events.dart';
import 'package:posts_app_flutter/features/posts/presentation/bloc/posts/posts_states.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetAllPostsUseCase getAllPostsUseCase;

  PostsBloc({required this.getAllPostsUseCase}) : super(PostsInitialState()) {
    on<PostsEvent>((event, emit) async {
      if(event is GetPostsEvent) {
        emit(PostsLoadingState());
        final data = await getAllPostsUseCase();
        data.fold(
          (failure) => emit(PostsErrorState(message: NetworkExceptions.getErrorMessage(failure))),
          (posts) => emit(PostsSuccessState(posts: posts))
        );
      }
    });
  }
  static PostsBloc get(context) => BlocProvider.of(context);
}
