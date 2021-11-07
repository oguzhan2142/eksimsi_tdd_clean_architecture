import 'package:dio/dio.dart';
import 'package:eksimsi_tdd_clean_architecture/core/constants/remote_source_constants.dart';
import 'package:eksimsi_tdd_clean_architecture/core/error/exception.dart';
import 'package:eksimsi_tdd_clean_architecture/core/utils/query_parameter_parser.dart';
import 'package:eksimsi_tdd_clean_architecture/features/entries/data/models/header_model.dart';
import 'package:eksimsi_tdd_clean_architecture/features/entries/data/models/entries_page_model.dart';



import 'package:html/parser.dart';

abstract class EntriesRepositoryRemoteDataSource {
  Future<EntriesPageModel> getEntriesPage(
      {required String href, int? page});

  Future<List<HeaderModel>> getHeaders();
}

class EntriesRepositoryRemoteDataSourceImpl
    extends EntriesRepositoryRemoteDataSource {
  final Dio client;

  EntriesRepositoryRemoteDataSourceImpl({required this.client});

  @override
  Future<List<HeaderModel>> getHeaders() async {
    final response =
        await client.get('https://eksisozluk.com/basliklar/gundem');

    if (response.statusCode != 200) {
      throw ServerException();
    }

    final data = response.data;

    final models = <HeaderModel>[];

    final document = parse(data);

    final body = document.body;

    if (body == null) {
      throw ServerException();
    }
    final contentsDiv = body.getElementsByClassName('instapaper_body').first;

    final ulElement = contentsDiv.getElementsByClassName('topic-list').first;

    final liElements = ulElement.getElementsByTagName('li');

    liElements.forEach((element) {
      models.add(HeaderModel.fromLiTag(element));
    });

    return models;
  }

  @override
  Future<EntriesPageModel> getEntriesPage(
      {required String href, int? page}) async {
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

    return EntriesPageModel.fromBody(body: body,rawHref: href);
  }
}
