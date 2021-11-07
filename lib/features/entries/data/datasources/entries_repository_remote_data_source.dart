import 'package:dio/dio.dart';
import 'package:eksimsi_tdd_clean_architecture/core/constants/remote_source_constants.dart';
import 'package:eksimsi_tdd_clean_architecture/core/error/exception.dart';
import 'package:eksimsi_tdd_clean_architecture/core/utils/query_parameter_parser.dart';
import 'package:eksimsi_tdd_clean_architecture/features/entries/data/models/entries_page_model.dart';
import 'package:eksimsi_tdd_clean_architecture/features/headers/data/models/header_model.dart';
import 'package:html/parser.dart';

abstract class EntriesRepositoryRemoteDataSource {
  Future<EntriesPageModel> getEntriesPage({
    required String href,
    int? page,
  });
}

class EntriesRepositoryRemoteDataSourceImpl
    extends EntriesRepositoryRemoteDataSource {
  final Dio client;

  EntriesRepositoryRemoteDataSourceImpl({required this.client});

  @override
  Future<EntriesPageModel> getEntriesPage({
    required String href,
    int? page,
  }) async {
    final url = EKSI_BASE_DOMAIN + href;

    final parser = QueryParameterParser(url: url);

    final response = await client.get(
      url,
      queryParameters: parser.parameters,
    );

    if (response.statusCode != 200) {
      throw ServerException();
    }

    final document = parse(response.data);
    final body = document.body;

    if (body == null) {
      throw ServerException();
    }

    return EntriesPageModel.fromBody(body: body, rawHref: href);
  }
}
