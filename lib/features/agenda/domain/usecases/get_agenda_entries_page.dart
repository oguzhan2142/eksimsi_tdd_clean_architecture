import 'package:eksimsi_tdd_clean_architecture/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:eksimsi_tdd_clean_architecture/core/usecases/usecase.dart';
import 'package:eksimsi_tdd_clean_architecture/features/agenda/domain/entities/entries_page.dart';
import 'package:eksimsi_tdd_clean_architecture/features/agenda/domain/repositories/agenda_repository.dart';

class GetAgendaEntriesPage extends UseCase<AgendaEntriesPage, NoParams> {
  final AgendaRepository agendaRepository;

  GetAgendaEntriesPage(this.agendaRepository);

  @override
  Future<Either<Failure, AgendaEntriesPage>> call(NoParams params) async {
    return await agendaRepository.getAgendaEntriesPage();
  }
}