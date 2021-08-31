import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/agenda_header.dart';
import '../entities/entries_page.dart';

abstract class AgendaRepository {
  Future<Either<Failure, List<AgendaHeader>>> getAgendaHeaders();


  Future<Either<Failure,EntriesPage>> getAgendaEntriesPage();


}
