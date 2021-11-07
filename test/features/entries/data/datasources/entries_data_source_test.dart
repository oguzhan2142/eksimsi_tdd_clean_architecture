import 'package:dio/dio.dart';
import 'package:eksimsi_tdd_clean_architecture/core/error/exception.dart';
import 'package:eksimsi_tdd_clean_architecture/features/entries/data/datasources/entries_repository_remote_data_source.dart';
import 'package:eksimsi_tdd_clean_architecture/features/entries/data/models/entries_page_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'agenda_repository_remote_data_source_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  late MockDio mockDio;
  late EntriesRepositoryRemoteDataSourceImpl remoteDataSource;

  void _setUpMockDioSuccessResponse(String fixture, {String url = ''}) {
    when(mockDio.get(any,queryParameters: anyNamed('queryParameters'))).thenAnswer(
      (_) async => Response(
        requestOptions: RequestOptions(path: url),
        statusCode: 200,
        data: fixtureAsString(fixture),
      ),
    );
  }

  void _setUpDioUnsuccessResponse({String url = ''}) {
    when(mockDio.get(any,queryParameters: anyNamed("queryParameters"))).thenAnswer(
      (_) async => Response(
        requestOptions: RequestOptions(path: url),

        statusCode: 404,
      ),
    );
  }

  setUp(() {
    mockDio = MockDio();
    remoteDataSource = EntriesRepositoryRemoteDataSourceImpl(client: mockDio);
  });

  group('getAgendaEntriesPageModel', () {
    test('should return AgendaEntriesPageModel when status code is 200',
        () async {
      // arrange
      
      _setUpMockDioSuccessResponse('entries_page.html');
      // act
      final result = await remoteDataSource.getEntriesPage(href: '',page: 1);
      // assert
      expect(result, isA<EntriesPageModel>());
    });

    test('should throws ServerException when status code is not 200', () async {
      // arrange
      _setUpDioUnsuccessResponse();
      // act
      final call = remoteDataSource.getEntriesPage;

      // assert

      expect(() => call(href: '',page: 1), throwsA(const TypeMatcher<ServerException>()));
    });
  });

  group('getAgendaHeaders', () {
    const agendaPageUrl = 'https://eksisozluk.com/basliklar/gundem';

    test('should send get request to https://eksisozluk.com/basliklar/gundem',
        () async {
      // arrange
      _setUpMockDioSuccessResponse('gundem.html', url: agendaPageUrl);

      // act
      await remoteDataSource.getHeaders();

      // assert
      verify(mockDio.get(agendaPageUrl));
    });

    test('should return list of AgendaHeaderModels when response code is 200',
        () async {
      // arrange
      _setUpMockDioSuccessResponse('gundem.html');

      // act
      final models = await remoteDataSource.getHeaders();

      // assert
      expect(models, isNotEmpty);
    });

    test('should throw server exception when status code is not 200', () {
      // arrange
      _setUpDioUnsuccessResponse(url: agendaPageUrl);

      // act
      final call = remoteDataSource.getHeaders;
      // assert
      expect(() => call(), throwsA(const TypeMatcher<ServerException>()));
    });
  });
}
