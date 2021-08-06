import 'package:dio/dio.dart';
import 'package:eksimsi_tdd_clean_architecture/features/agenda/data/models/agenda_entries_page_model.dart';
import 'package:eksimsi_tdd_clean_architecture/features/agenda/data/models/agenda_header_model.dart';

abstract class AgendaRepositoryRemoteDataSource {
  Future<AgendaEntriesPageModel> getAgendaEntriesPage();

  Future<List<AgendaHeaderModel>> getAgendaHeaders();
}

class AgendaRepositoryRemoteDataSourceImpl
    extends AgendaRepositoryRemoteDataSource {
  final Dio client;

  AgendaRepositoryRemoteDataSourceImpl({required this.client});

  @override
  Future<AgendaEntriesPageModel> getAgendaEntriesPage() {
    throw UnimplementedError();
  }

  @override
  Future<List<AgendaHeaderModel>> getAgendaHeaders() {
    throw UnimplementedError();
  }

  
}
