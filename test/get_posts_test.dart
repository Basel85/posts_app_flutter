import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:posts_app_flutter/core/network_exceptions/network_exceptions.dart';
import 'package:posts_app_flutter/features/posts/domain/use_cases/get_all_posts_use_case.dart';
import 'package:posts_app_flutter/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:posts_app_flutter/features/posts/presentation/bloc/posts/posts_events.dart';
import 'package:posts_app_flutter/features/posts/presentation/bloc/posts/posts_states.dart';

class MockGetAllPostsUseCase extends Mock implements GetAllPostsUseCase {}
class MockNetworkExceptions extends Mock implements NetworkExceptions {}

void main() {
  late PostsBloc bloc;
  late MockGetAllPostsUseCase mockGetAllPostsUseCase;
  late MockNetworkExceptions mockNetworkExceptions;

  setUp(() {
    mockGetAllPostsUseCase = MockGetAllPostsUseCase();
    bloc = PostsBloc(getAllPostsUseCase: mockGetAllPostsUseCase);
    mockNetworkExceptions = MockNetworkExceptions();
  });

  test('initial state should be PostsInitialState', () {
    // assert
    expect(bloc.state, equals(PostsInitialState()));
  });

  group('GetPostsEvent', () {
    test('should get data from the use case', () async {
      // arrange
      when(() => mockGetAllPostsUseCase())
          .thenAnswer((_) async => const Right([]));
      // act
      bloc.add(GetPostsEvent());
      await untilCalled(() => mockGetAllPostsUseCase());
      // assert
      verify(() => mockGetAllPostsUseCase());
    });

    test(
        'should emit [PostsLoadingState, PostsSuccessState] when data is gotten successfully',
        () async {
      // arrange
      when(() => mockGetAllPostsUseCase())
          .thenAnswer((_) async => const Right([]));
      // assert later
      final expected = [
        PostsLoadingState(),
        const PostsSuccessState(posts: []),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      // act
      bloc.add(GetPostsEvent());
    });

    test(
        'should emit [PostsLoadingState, PostsErrorState] when getting data fails',
        () async {
      // arrange
      when(() => mockGetAllPostsUseCase())
          .thenAnswer((im) async => Left(mockNetworkExceptions));
      // assert later
      final expected = [
        PostsLoadingState(),
        const PostsErrorState(message: 'Server Failure'),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      // act
      bloc.add(GetPostsEvent());
    });
  });

}
