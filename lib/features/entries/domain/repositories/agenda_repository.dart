import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/entries_page.dart';
import '../entities/header.dart';

abstract class AgendaRepository {
  Future<Either<Failure, List<Header>>> getHeaders();


  Future<Either<Failure,EntriesPage>> getAgendaEntriesPage(String url, int? page);


}
