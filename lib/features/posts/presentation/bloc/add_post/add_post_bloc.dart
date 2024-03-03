import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app_flutter/core/network_exceptions/network_exceptions.dart';
import 'package:posts_app_flutter/features/posts/domain/use_cases/create_post_use_case.dart';
import 'package:posts_app_flutter/features/posts/presentation/bloc/add_post/add_post_events.dart';
import 'package:posts_app_flutter/features/posts/presentation/bloc/add_post/add_post_states.dart';

class AddPostBloc extends Bloc<AddPostEvent, AddPostState> {
  final CreatePostUseCase _createPostUseCase;
  AddPostBloc(this._createPostUseCase) : super(AddPostInitialState()) {
    on<AddPostEvent>((event, emit) async {
      if (event is AddPostButtonEvent) {
        emit(AddPostLoadingState());
        final data = await _createPostUseCase(post: event.post);
        data.fold(
            (failure) => emit(AddPostErrorState(
                message: NetworkExceptions.getErrorMessage(failure))),
            (success) => emit(const AddPostSuccessState(
                message: 'Post added successfully!')));
      }
    });
  }
  static AddPostBloc get(context) => BlocProvider.of(context);
}
