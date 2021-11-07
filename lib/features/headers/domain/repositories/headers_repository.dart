import 'package:dartz/dartz.dart';
import 'package:eksimsi_tdd_clean_architecture/core/error/failures.dart';
import 'package:eksimsi_tdd_clean_architecture/features/headers/domain/entities/header.dart';

abstract class HeadersRepository {
  
  Future<Either<Failure, List<Header>>> getHeaders();

}
