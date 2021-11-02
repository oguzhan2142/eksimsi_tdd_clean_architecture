import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/agenda_header.dart';
import '../repositories/agenda_repository.dart';

class GetAgendaHeaders{
  final AgendaRepository agendaRepository;

  GetAgendaHeaders(this.agendaRepository);

  Future<Either<Failure, List<AgendaHeader>>> call() async {
    return await agendaRepository.getAgendaHeaders();
  }
}
