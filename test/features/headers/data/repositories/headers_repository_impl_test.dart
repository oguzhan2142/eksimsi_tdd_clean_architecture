import 'package:dartz/dartz.dart';
import 'package:eksimsi_tdd_clean_architecture/core/error/exception.dart';
import 'package:eksimsi_tdd_clean_architecture/core/error/failures.dart';
import 'package:eksimsi_tdd_clean_architecture/core/platform/network_info.dart';
import 'package:eksimsi_tdd_clean_architecture/features/headers/data/datasources/headers_repository_remote_data_source.dart';
import 'package:eksimsi_tdd_clean_architecture/features/headers/data/models/header_model.dart';
import 'package:eksimsi_tdd_clean_architecture/features/headers/data/repositories/headers_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';


import 'headers_repository_impl_test.mocks.dart';

@GenerateMocks([HeadersRepositoryRemoteDataSource,NetworkInfo])
void main() {
  late HeadersRepositoryImpl agendaRepositoryImp;
  late MockHeadersRepositoryRemoteDataSource remoteDataSource;

  late MockNetworkInfo mockNetworkInfo;

  final agendaHeaders = <HeaderModel>[
    HeaderModel(title: 'title', href: '23', entryAmount: '1')
  ];

  setUp(() {
    remoteDataSource = MockHeadersRepositoryRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();

    agendaRepositoryImp = HeadersRepositoryImpl(
      remoteDataSource: remoteDataSource,
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
      when(remoteDataSource.getHeaders(href: anyNamed('href')))
          .thenAnswer((_) async => agendaHeaders);
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

      // act
      agendaRepositoryImp.getHeaders(href: '');

      // assert
      verify(mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {
      test('should return remote data when remote data call is successfull',
          () async {
        // arrange
        when(remoteDataSource.getHeaders(href: anyNamed('href')))
            .thenAnswer((_) async => agendaHeaders);
        // act
        final headers = await agendaRepositoryImp.getHeaders(href: '');

        // assert
        verify(remoteDataSource.getHeaders(href: anyNamed('href')));
        expect(headers, equals(Right(agendaHeaders)));
      });

      test('should return server failure when remote data call is unsucessfull',
          () async {
        // arrange
        when(remoteDataSource.getHeaders(href: anyNamed('href'))).thenThrow(ServerException());
        // act
        final result = await agendaRepositoryImp.getHeaders(href: '');
        // assert
        verify(remoteDataSource.getHeaders(href: anyNamed('href')));
        verifyNoMoreInteractions(remoteDataSource);
        expect(result, Left(ServerFailure()));
      });
    });

    runTestsOffline(() {
      test('should return NoInternet Failure when not connected to internet',
          () async {
        // arrange
        when(remoteDataSource.getHeaders(href: anyNamed('href'))).thenThrow(NoInternetException());
        // act
        final result = await agendaRepositoryImp.getHeaders(href: '');
        // assert
        expect(Left(NoInternetFailure()), result);
      });
    });
  });
}
