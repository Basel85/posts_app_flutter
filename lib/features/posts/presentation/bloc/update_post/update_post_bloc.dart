import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app_flutter/core/network_exceptions/network_exceptions.dart';
import 'package:posts_app_flutter/features/posts/domain/use_cases/update_post_use_case.dart';
import 'package:posts_app_flutter/features/posts/presentation/bloc/update_post/update_post_events.dart';
import 'package:posts_app_flutter/features/posts/presentation/bloc/update_post/update_post_states.dart';

class UpdatePostBloc extends Bloc<UpdatePostEvent, UpdatePostState> {
  final UpdatePostUseCase _updatePostUseCase;
  UpdatePostBloc(this._updatePostUseCase) : super(UpdatePostInitialState()) {
    on<UpdatePostEvent>((event, emit) async {
      if (event is UpdatePostButtonEvent) {
        emit(UpdatePostLoadingState());
        final data = await _updatePostUseCase(post: event.post);
        data.fold((failure) {
          emit(UpdatePostErrorState(
              message: NetworkExceptions.getErrorMessage(failure)));
        }, (_) {
          emit(const UpdatePostSuccessState(
              message: 'Post updated successfully'));
        });
      }
    });
  }
  static UpdatePostBloc get(context) => BlocProvider.of(context);
}
