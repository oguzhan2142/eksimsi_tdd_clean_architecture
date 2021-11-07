import 'package:dartz/dartz.dart';

import 'package:eksimsi_tdd_clean_architecture/core/parameters/href_parameter.dart';
import 'package:eksimsi_tdd_clean_architecture/core/usecases/usecase.dart';
import 'package:eksimsi_tdd_clean_architecture/features/headers/domain/repositories/headers_repository.dart';

import '../../../../core/error/failures.dart';
import '../entities/header.dart';

class GetEntriesHeaders extends UseCase<List<Header>, HrefParameter> {
  final HeadersRepository agendaRepository;

  GetEntriesHeaders(this.agendaRepository);

  @override
  Future<Either<Failure, List<Header>>> call({
    required HrefParameter parameter,
  }) {
    return agendaRepository.getHeaders(href: parameter.href);
  }
}
