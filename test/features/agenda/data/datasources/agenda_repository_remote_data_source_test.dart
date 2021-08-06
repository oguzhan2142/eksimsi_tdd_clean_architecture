import 'package:dio/dio.dart';
import 'package:eksimsi_tdd_clean_architecture/features/agenda/data/datasources/agenda_repository_remote_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'agenda_repository_remote_data_source_test.mocks.dart';

@GenerateMocks([Dio])
main() {
  late MockDio mockDio;
  late AgendaRepositoryRemoteDataSourceImpl remoteDataSource;

  setUp(() {
    mockDio = MockDio();
    remoteDataSource = AgendaRepositoryRemoteDataSourceImpl(client: mockDio);
  });

  test('should send get request to https://eksisozluk.com/basliklar/gundem',
      () {
    // arrange
    when(remoteDataSource.getAgendaHeaders())
        .thenAnswer((_) async => []);
    // act
    // assert
  });
}
