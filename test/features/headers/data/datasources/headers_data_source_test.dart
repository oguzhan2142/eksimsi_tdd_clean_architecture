import 'package:dio/dio.dart';
import 'package:eksimsi_tdd_clean_architecture/core/error/exception.dart';
import 'package:eksimsi_tdd_clean_architecture/features/headers/data/datasources/headers_repository_remote_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../entries/data/datasources/agenda_repository_remote_data_source_test.mocks.dart';

void main() {
  late MockDio mockDio;
  late HeadersRepositoryRemoteDataSourceImpl remoteDataSource;

  setUp(() {
    mockDio = MockDio();
    remoteDataSource = HeadersRepositoryRemoteDataSourceImpl(client: mockDio);
  });
  void _setUpMockDioSuccessResponse(String fixture, {String url = ''}) {
    when(mockDio.get(any, queryParameters: anyNamed('queryParameters')))
        .thenAnswer(
      (_) async => Response(
        requestOptions: RequestOptions(path: url),
        statusCode: 200,
        data: fixtureAsString(fixture),
      ),
    );
  }

  void _setUpDioUnsuccessResponse({String url = ''}) {
    when(mockDio.get(any, queryParameters: anyNamed("queryParameters")))
        .thenAnswer(
      (_) async => Response(
        requestOptions: RequestOptions(path: url),
        statusCode: 404,
      ),
    );
  }

  group('getAgendaHeaders', () {
    const agendaPageUrl = 'https://eksisozluk.com/basliklar/gundem';

    test('should send get request to https://eksisozluk.com/basliklar/gundem',
        () async {
      // arrange
      _setUpMockDioSuccessResponse('gundem.html', url: agendaPageUrl);

      // act
      await remoteDataSource.getHeaders(href: '');

      // assert
      verify(mockDio.get(agendaPageUrl));
    });

    test('should return list of AgendaHeaderModels when response code is 200',
        () async {
      // arrange
      _setUpMockDioSuccessResponse('gundem.html');

      // act
      final models = await remoteDataSource.getHeaders(href: '');

      // assert
      expect(models, isNotEmpty);
    });

    test('should throw server exception when status code is not 200', () {
      // arrange
      _setUpDioUnsuccessResponse(url: agendaPageUrl);

      // act
      final call = remoteDataSource.getHeaders;
      // assert
      expect(() => call(href: ''), throwsA(const TypeMatcher<ServerException>()));
    });
  });
}
