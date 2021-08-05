import 'package:dartz/dartz.dart';
import 'package:eksimsi_tdd_clean_architecture/core/error/failures.dart';
import 'package:eksimsi_tdd_clean_architecture/core/usecases/usecase.dart';
import 'package:eksimsi_tdd_clean_architecture/features/agenda/domain/entities/agenda_header.dart';
import 'package:eksimsi_tdd_clean_architecture/features/agenda/domain/repositories/agenda_repository.dart';

class GetAgendaHeaders extends UseCase<List<AgendaHeader>,NoParams>{
  final AgendaRepository agendaRepository;

  GetAgendaHeaders(this.agendaRepository);

  Future<Either<Failure, List<AgendaHeader>>> call(NoParams noParams) async {
    return await agendaRepository.getAgendaHeaders();
  }
}
