import 'package:dartz/dartz.dart';
import 'package:eksimsi_tdd_clean_architecture/core/parameters/href_page_parameter.dart';


import 'package:eksimsi_tdd_clean_architecture/core/usecases/usecase.dart';

import '../../../../core/error/failures.dart';
import '../entities/entries_page.dart';
import '../repositories/entries_repository.dart';

class GetAgendaEntriesPage
    extends UseCase<EntriesPage, HrefPageParameter> {
  final EntriesRepository agendaRepository;

  GetAgendaEntriesPage(this.agendaRepository);

  @override
  Future<Either<Failure, EntriesPage>> call({
    required HrefPageParameter parameter,
  }) async {
    return agendaRepository.getAgendaEntriesPage(parameter.href, parameter.page);
  }
}
