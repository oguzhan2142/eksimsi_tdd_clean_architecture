import 'package:dartz/dartz.dart';
import 'package:eksimsi_tdd_clean_architecture/core/constants/error_messages.dart';
import 'package:eksimsi_tdd_clean_architecture/core/error/failures.dart';
import 'package:eksimsi_tdd_clean_architecture/core/usecases/usecase.dart';
import 'package:eksimsi_tdd_clean_architecture/features/agenda/domain/entities/agenda_header.dart';
import 'package:eksimsi_tdd_clean_architecture/features/agenda/domain/usecases/get_agenda_headers.dart';
import 'package:eksimsi_tdd_clean_architecture/features/agenda/presentation/blocs/headers_bloc/headers_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'headers_bloc_test.mocks.dart';

@GenerateMocks([GetAgendaHeaders])
main() {
  late MockGetAgendaHeaders getAgendaHeaders;
  late HeadersBloc bloc;

  setUp(() {
    getAgendaHeaders = MockGetAgendaHeaders();

    bloc = HeadersBloc(getAgendaHeaders: getAgendaHeaders);
  });

  test('initialState should be HeadersInitial', () {
    // assert
    expect(bloc.state, equals(HeadersInitial()));
  });

  group('GetHeadersEvent', () {
    final headers = <AgendaHeader>[
      AgendaHeader(title: 'title 1', href: 'asd', entryAmount: '1'),
      AgendaHeader(title: 'title 2', href: 'asdasd', entryAmount: '43'),
    ];

    test('should emit [GetHeadersError] when cant get data from source', () {
      // arrange
      when(getAgendaHeaders())
          .thenAnswer((realInvocation) => Future.value(Left(ServerFailure())));
      final expected = [
        GetAgendaHeadersInProgress(),
        GetAgendaHeadersFailed(message: SERVER_ERROR_MESSAGE),
      ];

      // assert
      expectLater(bloc.stream, emitsInOrder(expected));

      // act
      bloc.add(GetAgendaHeadersEvent());
    });

    test('should emit [GetHeadersError] when no internet connection', () {
      // arrange
      when(getAgendaHeaders()).thenAnswer(
          (realInvocation) => Future.value(Left(NoInternetFailure())));

      final expected = [
        GetAgendaHeadersInProgress(),
        GetAgendaHeadersFailed(message: NO_INTERNET_MESSAGE),
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
}
