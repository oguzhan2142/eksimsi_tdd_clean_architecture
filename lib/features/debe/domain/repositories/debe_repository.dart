import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/debe_header.dart';

abstract class DebeRepository{

  Future<Either<Failure,List<DebeHeader>>> getDebeHeaders();


}