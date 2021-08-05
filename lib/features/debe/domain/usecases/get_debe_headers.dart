import 'package:eksimsi_tdd_clean_architecture/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:eksimsi_tdd_clean_architecture/core/usecases/usecase.dart';
import 'package:eksimsi_tdd_clean_architecture/features/debe/domain/entities/debe_header.dart';
import 'package:eksimsi_tdd_clean_architecture/features/debe/domain/repositories/debe_repository.dart';

class GetDebeHeaders extends UseCase<List<DebeHeader>, NoParams> {
  final DebeRepository debeRepository;

  GetDebeHeaders(this.debeRepository);

  @override
  Future<Either<Failure, List<DebeHeader>>> call(NoParams noParams) async {
    return await debeRepository.getDebeHeaders();
  }
}
