import 'package:dartz/dartz.dart';
import 'package:eksimsi_tdd_clean_architecture/core/error/failures.dart';
import 'package:eksimsi_tdd_clean_architecture/core/parameters/parameter.dart';
import 'package:eksimsi_tdd_clean_architecture/features/channels/domain/entities/channel_header.dart';
import 'package:eksimsi_tdd_clean_architecture/features/channels/domain/repositories/channel_repository.dart';
import 'package:eksimsi_tdd_clean_architecture/features/channels/domain/usecases/get_channel_headers.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../entities/channel_header_test.mocks.dart';
import 'get_channel_headers_test.mocks.dart';

@GenerateMocks([ChannelRepository])
void main() {
  late MockChannelRepository channelRepository;

  late List<MockChannelHeader> channelHeaders;
  late GetChannelHeaders getChannelHeaders;

  setUp(() {
    channelRepository = MockChannelRepository();
    channelHeaders = List.generate(10, (index) => MockChannelHeader());
    getChannelHeaders = GetChannelHeaders(channelRepository: channelRepository);
  });

  test('should execute channelRepository.getAgendaHeaders method', () {
    // arrange
    when(channelRepository.getChannelHeaders())
        .thenAnswer((_) async => Right(channelHeaders));

    // act
    getChannelHeaders.call(parameter: NoParameter());

    // assert
    verify(channelRepository.getChannelHeaders());
  });

  test('should return Failure when repository returns failure', () {
    // arrange
    when(channelRepository.getChannelHeaders())
        .thenAnswer((_) async => Left(ServerFailure()));
    // act

    final failureOrHeaders = getChannelHeaders.call(parameter: NoParameter());

    // assert
  });
}
