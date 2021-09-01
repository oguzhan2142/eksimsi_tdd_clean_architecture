import 'package:dio/dio.dart';
import 'package:eksimsi_tdd_clean_architecture/core/error/exception.dart';
import 'package:eksimsi_tdd_clean_architecture/features/agenda/data/datasources/agenda_repository_remote_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'agenda_repository_remote_data_source_test.mocks.dart';

@GenerateMocks([Dio])
main() {
  late MockDio mockDio;
  late AgendaRepositoryRemoteDataSourceImpl remoteDataSource;
  

  setUp(() {
    mockDio = MockDio();
    remoteDataSource = AgendaRepositoryRemoteDataSourceImpl(client: mockDio);
  });

  group('getAgendaHeaders', () {

    final agendaPageUrl = 'https://eksisozluk.com/basliklar/gundem';

    void _setUpMockDioSuccessResponse() {
      when(mockDio.get(any)).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: agendaPageUrl),
          statusCode: 200,
          data: fixtureAsString('gundem.html'),
        ),
      );
    }

    test('should send get request to https://eksisozluk.com/basliklar/gundem',
        () async {
      // arrange
      _setUpMockDioSuccessResponse();

      // act
      await remoteDataSource.getAgendaHeaders();

      // assert
      verify(mockDio.get(agendaPageUrl));
    });

    test('should return list of AgendaHeaderModels when response code is 200',
        () async {
      // arrange
      _setUpMockDioSuccessResponse();

      // act
      final models = await remoteDataSource.getAgendaHeaders();

      // assert
      expect(models, isNotEmpty);
    });

    test('should throw server exception when status code is not 200', () {
      // arrange
      when(mockDio.get(any)).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: agendaPageUrl),
          statusCode: 404,
        ),
      );

      // act
      final call = remoteDataSource.getAgendaHeaders;
      // assert
      expect(() => call(), throwsA(TypeMatcher<ServerException>()));
    });
  });
}
