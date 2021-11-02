import 'package:dartz/dartz.dart';
import 'package:eksimsi_tdd_clean_architecture/core/parameters/get_agenda_entry_page_parameter.dart';


import 'package:eksimsi_tdd_clean_architecture/core/usecases/usecase.dart';

import '../../../../core/error/failures.dart';
import '../entities/entries_page.dart';
import '../repositories/agenda_repository.dart';

class GetAgendaEntriesPage
    extends UseCase<EntriesPage, GetAgendaEntriesPageParameter> {
  final AgendaRepository agendaRepository;

  GetAgendaEntriesPage(this.agendaRepository);

  @override
  Future<Either<Failure, EntriesPage>> call({
    required GetAgendaEntriesPageParameter parameter,
  }) async {
    return agendaRepository.getAgendaEntriesPage(parameter.href, parameter.page);
  }
}
