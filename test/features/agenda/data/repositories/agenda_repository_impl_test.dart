import 'package:dartz/dartz.dart';
import 'package:eksimsi_tdd_clean_architecture/core/error/exception.dart';
import 'package:eksimsi_tdd_clean_architecture/core/error/failures.dart';
import 'package:eksimsi_tdd_clean_architecture/core/platform/network_info.dart';
import 'package:eksimsi_tdd_clean_architecture/features/agenda/data/datasources/agenda_repository_remote_data_source.dart';
import 'package:eksimsi_tdd_clean_architecture/features/agenda/data/repositories/agenda_repository_impl.dart';
import 'package:eksimsi_tdd_clean_architecture/features/agenda/domain/entities/agenda_header.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'agenda_repository_impl_test.mocks.dart';

@GenerateMocks([AgendaRepositoryRemoteDataSource, NetworkInfo])
main() {
  late AgendaRepositoryImp agendaRepositoryImp;
  late MockAgendaRepositoryRemoteDataSource
      mockAgendaRepositoryRemoteDataSource;

  late MockNetworkInfo mockNetworkInfo;
  final agendaHeader = AgendaHeader(
    title: 'haer',
    href: 'asd',
    entryAmount: '2',
  );
  final agendaHeaders = <AgendaHeader>[
    AgendaHeader(title: 'title', href: '23', entryAmount: '1')
  ];

  setUp(() {
    mockAgendaRepositoryRemoteDataSource =
        MockAgendaRepositoryRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();

    agendaRepositoryImp = AgendaRepositoryImp(
      agendaRepositoryRemoteDataSource: mockAgendaRepositoryRemoteDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runTestsOffline(Function body) {
    setUp(() {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
    });

    body();
  }

  group('GetAgendaHeader', () {
    test('should check device is online', () async {
      // arrange
      when(mockAgendaRepositoryRemoteDataSource.getAgendaHeaders())
          .thenAnswer((_) async => agendaHeaders);
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

      // act
      agendaRepositoryImp.getAgendaHeaders();

      // assert
      verify(mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {
      test('should return remote data when remote data call is successfull',
          () async {
        // arrange
        when(mockAgendaRepositoryRemoteDataSource.getAgendaHeaders())
            .thenAnswer((_) async => agendaHeaders);
        // act
        final headers = await agendaRepositoryImp.getAgendaHeaders();

        // assert
        verify(mockAgendaRepositoryRemoteDataSource.getAgendaHeaders());
        expect(headers, equals(Right(agendaHeaders)));
      });

      test('should return server failure when remote data call is unsucessfull',
          () async {
        // arrange
        when(mockAgendaRepositoryRemoteDataSource.getAgendaHeaders())
            .thenThrow(ServerException());
        // act
        final result = await agendaRepositoryImp.getAgendaHeaders();
        // assert
        verify(mockAgendaRepositoryRemoteDataSource.getAgendaHeaders());
        verifyNoMoreInteractions(mockAgendaRepositoryRemoteDataSource);
        expect(result, Left(ServerFailure()));
      });
    });

    runTestsOffline(() {
      test('should return NoInternet Failure when not connected to internet',
          () async {
        // arrange
        when(mockAgendaRepositoryRemoteDataSource.getAgendaHeaders())
            .thenThrow(NoInternetException());
        // act
        final result = await agendaRepositoryImp.getAgendaHeaders();
        // assert
        expect(Left(NoInternetFailure()), result);
      });
    });
  });
}
