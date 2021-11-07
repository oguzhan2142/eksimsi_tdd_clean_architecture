import 'package:dartz/dartz.dart';
import 'package:eksimsi_tdd_clean_architecture/core/error/failures.dart';
import 'package:eksimsi_tdd_clean_architecture/features/headers/domain/entities/channel_header.dart';
import 'package:eksimsi_tdd_clean_architecture/features/headers/domain/entities/header.dart';

abstract class HeadersRepository {
  Future<Either<Failure, List<Header>>> getHeaders({required String href});

  Future<Either<Failure, List<ChannelHeader>>> getChannelHeaders();
}
