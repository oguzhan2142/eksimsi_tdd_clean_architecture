import 'package:dartz/dartz.dart';
import 'package:eksimsi_tdd_clean_architecture/core/error/exception.dart';
import 'package:eksimsi_tdd_clean_architecture/core/error/failures.dart';
import 'package:eksimsi_tdd_clean_architecture/core/platform/network_info.dart';

import 'package:eksimsi_tdd_clean_architecture/features/entries/data/datasources/entries_repository_remote_data_source.dart';
import 'package:eksimsi_tdd_clean_architecture/features/entries/data/models/header_model.dart';
import 'package:eksimsi_tdd_clean_architecture/features/entries/data/repositories/entries_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'entries_repository_impl_test.mocks.dart';

@GenerateMocks([EntriesRepositoryRemoteDataSource, NetworkInfo])
void main() {
  late AgendaRepositoryImp agendaRepositoryImp;
  late MockEntriesRepositoryRemoteDataSource
      mockAgendaRepositoryRemoteDataSource;

  late MockNetworkInfo mockNetworkInfo;

  final agendaHeaders = <HeaderModel>[
    HeaderModel(title: 'title', href: '23', entryAmount: '1')
  ];

  setUp(() {
    mockAgendaRepositoryRemoteDataSource =
        MockEntriesRepositoryRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();

    agendaRepositoryImp = AgendaRepositoryImp(
      entriesRepositoryRemoteDataSource: mockAgendaRepositoryRemoteDataSource,
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
      when(mockAgendaRepositoryRemoteDataSource.getHeaders())
          .thenAnswer((_) async => agendaHeaders);
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

      // act
      agendaRepositoryImp.getHeaders();

      // assert
      verify(mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {
      test('should return remote data when remote data call is successfull',
          () async {
        // arrange
        when(mockAgendaRepositoryRemoteDataSource.getHeaders())
            .thenAnswer((_) async => agendaHeaders);
        // act
        final headers = await agendaRepositoryImp.getHeaders();

        // assert
        verify(mockAgendaRepositoryRemoteDataSource.getHeaders());
        expect(headers, equals(Right(agendaHeaders)));
      });

      test('should return server failure when remote data call is unsucessfull',
          () async {
        // arrange
        when(mockAgendaRepositoryRemoteDataSource.getHeaders())
            .thenThrow(ServerException());
        // act
        final result = await agendaRepositoryImp.getHeaders();
        // assert
        verify(mockAgendaRepositoryRemoteDataSource.getHeaders());
        verifyNoMoreInteractions(mockAgendaRepositoryRemoteDataSource);
        expect(result, Left(ServerFailure()));
      });
    });

    runTestsOffline(() {
      test('should return NoInternet Failure when not connected to internet',
          () async {
        // arrange
        when(mockAgendaRepositoryRemoteDataSource.getHeaders())
            .thenThrow(NoInternetException());
        // act
        final result = await agendaRepositoryImp.getHeaders();
        // assert
        expect(Left(NoInternetFailure()), result);
      });
    });
  });
}
