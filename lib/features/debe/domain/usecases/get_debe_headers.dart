import 'package:dartz/dartz.dart';
import 'package:eksimsi_tdd_clean_architecture/core/parameters/no_parameter.dart';
import 'package:eksimsi_tdd_clean_architecture/core/usecases/usecase.dart';

import '../../../../core/error/failures.dart';
import '../entities/debe_header.dart';
import '../repositories/debe_repository.dart';

class GetDebeHeaders extends UseCase<List<DebeHeader>, NoParameter> {
  final DebeRepository debeRepository;

  GetDebeHeaders(this.debeRepository);


  /// No need any parameter
  @override
  Future<Either<Failure, List<DebeHeader>>> call({
    required NoParameter parameter,
  }) async {
    return debeRepository.getDebeHeaders();
  }
}
