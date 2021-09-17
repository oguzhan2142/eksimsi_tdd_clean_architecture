import 'package:dio/dio.dart';
import 'package:eksimsi_tdd_clean_architecture/core/error/exception.dart';
import 'package:eksimsi_tdd_clean_architecture/features/agenda/data/models/agenda_header_model.dart';
import 'package:eksimsi_tdd_clean_architecture/features/agenda/data/models/entries_page_model.dart';
import 'package:html/parser.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

abstract class AgendaRepositoryRemoteDataSource {
  Future<AgendaEntriesPageModel> getAgendaEntriesPage(String url);

  Future<List<AgendaHeaderModel>> getAgendaHeaders();
}

class AgendaRepositoryRemoteDataSourceImpl
    extends AgendaRepositoryRemoteDataSource {
  final Dio client;

  AgendaRepositoryRemoteDataSourceImpl({required this.client});

  @override
  Future<AgendaEntriesPageModel> getAgendaEntriesPage(String url) async {
    final response = await client.get(url);
    if (response.statusCode != 200) {
      throw ServerException();
    }

    final document = parse(response.data);
    final body = document.body;

    if (body == null) {
      throw ServerException();
    }

    return AgendaEntriesPageModel.fromBody(body);
  }

  @override
  Future<List<AgendaHeaderModel>> getAgendaHeaders() async {

    final response =
        await client.get('https://eksisozluk.com/basliklar/gundem');

    if (response.statusCode != 200) {
      throw ServerException();
    }

    final data = response.data;

    final models = <AgendaHeaderModel>[];

    final document = parse(data);

    final body = document.body;

    if (body == null) {
      throw ServerException();
    }
    final contentsDiv = body.getElementsByClassName('instapaper_body').first;

    final ulElement = contentsDiv.getElementsByClassName('topic-list').first;

    final liElements = ulElement.getElementsByTagName('li');

    liElements.forEach((element) {
      models.add(AgendaHeaderModel.fromLiTag(element));
    });

    return models;
  }
}
