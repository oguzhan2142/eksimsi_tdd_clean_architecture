import 'package:dartz/dartz.dart';
import 'package:eksimsi_tdd_clean_architecture/core/error/failures.dart';

abstract class UseCase<T, BaseParameter> {
  Future<Either<Failure, T>> call({required BaseParameter parameter});
}


