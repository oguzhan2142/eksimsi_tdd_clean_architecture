import 'package:dartz/dartz.dart';
import 'package:eksimsi_tdd_clean_architecture/core/error/failures.dart';
import 'package:eksimsi_tdd_clean_architecture/core/parameters/no_parameter.dart';
import 'package:eksimsi_tdd_clean_architecture/core/usecases/usecase.dart';
import 'package:eksimsi_tdd_clean_architecture/features/headers/domain/entities/channel_header.dart';
import 'package:eksimsi_tdd_clean_architecture/features/headers/domain/repositories/headers_repository.dart';

class GetChannelHeaders extends UseCase<List<ChannelHeader>, NoParameter> {
  final HeadersRepository channelRepository;

  GetChannelHeaders({
    required this.channelRepository,
  });

  @override
  Future<Either<Failure, List<ChannelHeader>>> call({
    required NoParameter parameter,
  }) {
    return channelRepository.getChannelHeaders();
  }
}
