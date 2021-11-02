import 'package:dartz/dartz.dart';
import 'package:eksimsi_tdd_clean_architecture/core/error/failures.dart';
import 'package:eksimsi_tdd_clean_architecture/features/channels/domain/entities/channel_header.dart';

abstract class ChannelRepository {
  Future<Either<Failure,List<ChannelHeader>>> getChannelHeaders();
}
