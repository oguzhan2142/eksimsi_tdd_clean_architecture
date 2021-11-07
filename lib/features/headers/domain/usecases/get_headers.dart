import 'package:dartz/dartz.dart';
import 'package:eksimsi_tdd_clean_architecture/features/headers/domain/repositories/headers_repository.dart';

import '../../../../core/error/failures.dart';
import '../entities/header.dart';

class GetAgendaHeaders {
  final HeadersRepository agendaRepository;

  GetAgendaHeaders(this.agendaRepository);

  Future<Either<Failure, List<Header>>> call() async {
    return agendaRepository.getHeaders();
  }
}
