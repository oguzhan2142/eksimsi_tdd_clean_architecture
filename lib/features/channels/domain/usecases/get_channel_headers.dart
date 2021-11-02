import 'package:dartz/dartz.dart';
import 'package:eksimsi_tdd_clean_architecture/core/error/failures.dart';
import 'package:eksimsi_tdd_clean_architecture/core/parameters/parameter.dart';
import 'package:eksimsi_tdd_clean_architecture/core/usecases/usecase.dart';
import 'package:eksimsi_tdd_clean_architecture/features/channels/domain/entities/channel_header.dart';
import 'package:eksimsi_tdd_clean_architecture/features/channels/domain/repositories/channel_repository.dart';

class GetChannelHeaders extends UseCase<List<ChannelHeader>, NoParameter> {
  final ChannelRepository channelRepository;

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
