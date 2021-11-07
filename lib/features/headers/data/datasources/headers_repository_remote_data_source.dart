import 'package:dio/dio.dart';
import 'package:eksimsi_tdd_clean_architecture/core/error/exception.dart';
import 'package:eksimsi_tdd_clean_architecture/features/headers/data/models/header_model.dart';
import 'package:html/parser.dart';

abstract class HeadersRepositoryRemoteDataSource {
  Future<List<HeaderModel>> getHeaders();
}

class HeadersRepositoryRemoteDataSourceImpl
    extends HeadersRepositoryRemoteDataSource {
  final Dio client;

  HeadersRepositoryRemoteDataSourceImpl({required this.client});

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

    for (final element in liElements) {
      models.add(HeaderModel.fromLiTag(element));
    }

    return models;
  }
}
