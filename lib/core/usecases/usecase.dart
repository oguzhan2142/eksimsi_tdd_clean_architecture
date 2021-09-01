import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:eksimsi_tdd_clean_architecture/core/error/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}

class Params extends Equatable {
  String url;
  Params({required this.url});

  @override
  List<Object?> get props => [url];
}
