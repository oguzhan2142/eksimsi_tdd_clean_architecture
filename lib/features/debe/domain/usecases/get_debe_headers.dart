import 'package:dartz/dartz.dart';
import 'package:eksimsi_tdd_clean_architecture/core/error/failures.dart';
import 'package:eksimsi_tdd_clean_architecture/features/debe/domain/entities/debe_header.dart';
import 'package:eksimsi_tdd_clean_architecture/features/debe/domain/repositories/debe_repository.dart';

class GetDebeHeaders {
  final DebeRepository debeRepository;

  GetDebeHeaders(this.debeRepository);


  Future<Either<Failure, List<DebeHeader>>> call() async {
    return await debeRepository.getDebeHeaders();
  }
}
