@Timeout(Duration(seconds: 4))
import 'package:dartz/dartz.dart';
import 'package:eksimsi_tdd_clean_architecture/core/constants/error_messages.dart';
import 'package:eksimsi_tdd_clean_architecture/core/error/failures.dart';
import 'package:eksimsi_tdd_clean_architecture/features/headers/domain/entities/channel_header.dart';
import 'package:eksimsi_tdd_clean_architecture/features/headers/domain/entities/header.dart';
import 'package:eksimsi_tdd_clean_architecture/features/headers/domain/usecases/get_channel_headers.dart';
import 'package:eksimsi_tdd_clean_architecture/features/headers/domain/usecases/get_headers.dart';
import 'package:eksimsi_tdd_clean_architecture/features/headers/presentation/bloc/headers_bloc/headers_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'headers_bloc_test.mocks.dart';

@GenerateMocks([GetAgendaHeaders, GetChannelHeaders])
void main() {
  late MockGetAgendaHeaders getAgendaHeaders;
  late MockGetChannelHeaders getChannelHeaders;

  late HeadersBloc bloc;

  setUp(() {
    getAgendaHeaders = MockGetAgendaHeaders();
    getChannelHeaders = MockGetChannelHeaders();

    bloc = HeadersBloc(
      getAgendaHeaders: getAgendaHeaders,
      getChannelHeaders: getChannelHeaders,
    );
  });

  test('initialState should be HeadersInitial', () {
    // assert
    expect(bloc.state, equals(HeadersInitial()));
  });

  group(
    'channel headers',
    () {
      final channelHeaders = [
        ChannelHeader(title: 'title', href: 'href', subTitle: 'subTitle'),
      ];

      test(
          'should emit [ChannelHeadersError] state when cant get data from source',
          () {
        // arrange
        final expected = [
          GetChannelsHeadersInProgress(),
          const GetChannelHeadersError(message: SERVER_ERROR_MESSAGE),
        ];

        when(getChannelHeaders.call(parameter: anyNamed('parameter')))
            .thenAnswer((_) async => Left(ServerFailure()));

        // assert
        expectLater(bloc.stream, emitsInOrder(expected));

        // act
        bloc.add(GetChannelsHeadersEvent());
      });

      test(
          'should emit [GetChannelHeadersCompleted] when get valid data from source',
          () {
        // arrange
        final expected = [
          GetChannelsHeadersInProgress(),
          GetChannelHeadersCompleted(
            headers: channelHeaders,
          ),
        ];

        when(getChannelHeaders.call(parameter: anyNamed('parameter')))
            .thenAnswer(
          (_) async => Right(channelHeaders),
        );

        // assert
        expectLater(bloc.stream, emitsInOrder(expected));

        // act
        bloc.add(GetChannelsHeadersEvent());
      });

      test(
          'should emit [GetChannelHeadersError] with NO_INTERNET_MESSAGE when there is no internet connection',
          () {
        // arrange
        when(getChannelHeaders.call(parameter: anyNamed('parameter')))
            .thenAnswer((_) async => Left(NoInternetFailure()));
        const expectedFailureState =
            GetChannelHeadersError(message: NO_INTERNET_MESSAGE);

        // assert
        expectLater(bloc.stream, emitsThrough(expectedFailureState));

        // act
        bloc.add(GetChannelsHeadersEvent());
      });

      test(
          'should emit [GetChannelHeadersError] with SERVER_ERROR_MESSAGE when there is Server Failure',
          () {
        // arrange
        when(getChannelHeaders.call(parameter: anyNamed('parameter')))
            .thenAnswer((_) async => Left(ServerFailure()));
        const expectedFailureState =
            GetChannelHeadersError(message: SERVER_ERROR_MESSAGE);

        // assert
        expectLater(bloc.stream, emitsThrough(expectedFailureState));

        // act
        bloc.add(GetChannelsHeadersEvent());
      });
    },
  );

  group('agenda headers', () {
    group('GetHeadersEvent', () {
      final headers = <Header>[
        Header(title: 'title 1', href: 'asd', entryAmount: '1'),
        Header(title: 'title 2', href: 'asdasd', entryAmount: '43'),
      ];

      test('should emit [GetHeadersError] when cant get data from source', () {
        // arrange
        when(getAgendaHeaders()).thenAnswer(
          (realInvocation) => Future.value(Left(ServerFailure())),
        );
        final expected = [
          GetAgendaHeadersInProgress(),
          const GetAgendaHeadersFailed(message: SERVER_ERROR_MESSAGE),
        ];

        // assert
        expectLater(bloc.stream, emitsInOrder(expected));

        // act
        bloc.add(GetAgendaHeadersEvent());
      });

      test('should emit [GetHeadersError] when no internet connection', () {
        // arrange
        when(getAgendaHeaders()).thenAnswer(
          (realInvocation) => Future.value(Left(NoInternetFailure())),
        );

        final expected = [
          GetAgendaHeadersInProgress(),
          const GetAgendaHeadersFailed(message: NO_INTERNET_MESSAGE),
        ];

        // assert
        expectLater(bloc.stream, emitsInOrder(expected));

        // act
        bloc.add(GetAgendaHeadersEvent());
      });

      test(
          'should emit [GetAgendaHeadersInProgress] [GetAgendaHeadersCompleted] when data is gotten successfully',
          () {
        // arrange
        when(getAgendaHeaders())
            .thenAnswer((realInvocation) => Future.value(Right(headers)));

        final expected = [
          GetAgendaHeadersInProgress(),
          GetAgendaHeadersCompleted(headers: headers),
        ];

        // assert
        expectLater(bloc.stream, emitsInOrder(expected));

        // act
        bloc.add(GetAgendaHeadersEvent());
      });
    });
  });
}
