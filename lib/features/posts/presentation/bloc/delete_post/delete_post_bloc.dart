import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app_flutter/core/network_exceptions/network_exceptions.dart';
import 'package:posts_app_flutter/features/posts/domain/use_cases/delete_post_use_case.dart';
import 'package:posts_app_flutter/features/posts/presentation/bloc/delete_post/delete_post_events.dart';
import 'package:posts_app_flutter/features/posts/presentation/bloc/delete_post/delete_post_states.dart';

class DeletePostBloc extends Bloc<DeletePostEvent, DeletePostState> {
  final DeletePostUseCase _deletePostUseCase;
  DeletePostBloc(this._deletePostUseCase) : super(DeletePostInitialState()) {
    on<DeletePostEvent>((event, emit) async {
      if (event is DeletePostButtonEvent) {
        emit(DeletePostLoadingState());
        final data = await _deletePostUseCase(postId: event.postId);
        data.fold((failure) {
          emit(DeletePostErrorState(
              message: NetworkExceptions.getErrorMessage(failure)));
        }, (_) {
          emit(const DeletePostSuccessState(
              message: 'Post deleted successfully'));
        });
      }
    });
  }
  static DeletePostBloc get(context) => BlocProvider.of(context);
}
