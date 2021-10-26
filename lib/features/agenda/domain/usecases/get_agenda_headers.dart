import 'package:dartz/dartz.dart';
import 'package:eksimsi_tdd_clean_architecture/core/error/failures.dart';
import 'package:eksimsi_tdd_clean_architecture/features/agenda/domain/entities/agenda_header.dart';
import 'package:eksimsi_tdd_clean_architecture/features/agenda/domain/repositories/agenda_repository.dart';

class GetAgendaHeaders{
  final AgendaRepository agendaRepository;

  GetAgendaHeaders(this.agendaRepository);

  Future<Either<Failure, List<AgendaHeader>>> call() async {
    return await agendaRepository.getAgendaHeaders();
  }
}
