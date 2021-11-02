import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/entries_page.dart';
import '../repositories/agenda_repository.dart';

class GetAgendaEntriesPage  {
  final AgendaRepository agendaRepository;

  GetAgendaEntriesPage(this.agendaRepository);


  Future<Either<Failure, EntriesPage>> call(String url, int? page) async {
    return await agendaRepository.getAgendaEntriesPage(url,page);
  }
}
