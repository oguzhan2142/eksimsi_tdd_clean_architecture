import 'package:dio/dio.dart';
import 'package:eksimsi_tdd_clean_architecture/core/error/exception.dart';
import 'package:eksimsi_tdd_clean_architecture/features/agenda/data/datasources/agenda_repository_remote_data_source.dart';
import 'package:eksimsi_tdd_clean_architecture/features/agenda/data/models/entries_page_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'agenda_repository_remote_data_source_test.mocks.dart';

@GenerateMocks([Dio])
main() {
  late MockDio mockDio;
  late AgendaRepositoryRemoteDataSourceImpl remoteDataSource;

  void _setUpMockDioSuccessResponse(String fixture, {String url = ''}) {
    when(mockDio.get(any)).thenAnswer(
      (_) async => Response(
        requestOptions: RequestOptions(path: url),
        statusCode: 200,
        data: fixtureAsString(fixture),
      ),
    );
  }

  void _setUpDioUnsuccessResponse({String url = ''}) {
    when(mockDio.get(any)).thenAnswer(
      (_) async => Response(
        requestOptions: RequestOptions(path: url),
        statusCode: 404,
      ),
    );
  }

  setUp(() {
    mockDio = MockDio();
    remoteDataSource = AgendaRepositoryRemoteDataSourceImpl(client: mockDio);
  });

  group('getAgendaEntriesPageModel', () {
    test('should return AgendaEntriesPageModel when status code is 200',
        () async {
      // arrange
      _setUpMockDioSuccessResponse('entries_page.html');
      // act
      final result = await remoteDataSource.getAgendaEntriesPage('');
      // assert
      expect(result, isA<AgendaEntriesPageModel>());
    });

    test('should throws ServerException when status code is not 200', () async {
      // arrange
      _setUpDioUnsuccessResponse();
      // act
      final call = remoteDataSource.getAgendaEntriesPage;

      // assert

      expect(() => call(''), throwsA(TypeMatcher<ServerException>()));
    });
  });

  group('getAgendaHeaders', () {
    final agendaPageUrl = 'https://eksisozluk.com/basliklar/gundem';

    test('should send get request to https://eksisozluk.com/basliklar/gundem',
        () async {
      // arrange
      _setUpMockDioSuccessResponse('gundem.html', url: agendaPageUrl);

      // act
      await remoteDataSource.getAgendaHeaders();

      // assert
      verify(mockDio.get(agendaPageUrl));
    });

    test('should return list of AgendaHeaderModels when response code is 200',
        () async {
      // arrange
      _setUpMockDioSuccessResponse('gundem.html');

      // act
      final models = await remoteDataSource.getAgendaHeaders();

      // assert
      expect(models, isNotEmpty);
    });

    test('should throw server exception when status code is not 200', () {
      // arrange
      _setUpDioUnsuccessResponse(url: agendaPageUrl);

      // act
      final call = remoteDataSource.getAgendaHeaders;
      // assert
      expect(() => call(), throwsA(TypeMatcher<ServerException>()));
    });
  });
}
