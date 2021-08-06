import 'package:eksimsi_tdd_clean_architecture/features/agenda/domain/entities/agenda_entry.dart';
import 'package:eksimsi_tdd_clean_architecture/features/agenda/domain/entities/agenda_header.dart';
import 'package:eksimsi_tdd_clean_architecture/features/agenda/domain/entities/entries_page.dart';

abstract class AgendaRepositoryRemoteDataSource {
  Future<AgendaEntriesPage> getAgendaEntriesPage();

  Future<List<AgendaHeader>> getAgendaHeaders();
}
