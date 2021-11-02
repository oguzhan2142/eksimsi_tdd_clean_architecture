import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/debe_header.dart';
import '../repositories/debe_repository.dart';

class GetDebeHeaders {
  final DebeRepository debeRepository;

  GetDebeHeaders(this.debeRepository);


  Future<Either<Failure, List<DebeHeader>>> call() async {
    return await debeRepository.getDebeHeaders();
  }
}
