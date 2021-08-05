import 'package:dartz/dartz.dart';
import 'package:eksimsi_tdd_clean_architecture/core/error/failures.dart';
import 'package:eksimsi_tdd_clean_architecture/features/debe/domain/entities/debe_header.dart';

abstract class DebeRepository{

  Future<Either<Failure,List<DebeHeader>>> getDebeHeaders();


}