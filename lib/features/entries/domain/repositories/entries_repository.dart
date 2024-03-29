import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

import '../entities/entries_page.dart';

abstract class EntriesRepository {
  Future<Either<Failure, EntriesPage>> getAgendaEntriesPage(
    String url,
    int? page,
  );
}
