import 'package:eksimsi_tdd_clean_architecture/core/platform/network_info.dart';
import 'package:eksimsi_tdd_clean_architecture/features/agenda/data/datasources/agenda_repository_remote_data_source.dart';
import 'package:eksimsi_tdd_clean_architecture/features/agenda/data/repositories/agenda_repository_impl.dart';
import 'package:eksimsi_tdd_clean_architecture/features/agenda/domain/entities/agenda_header.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'agenda_repository_impl_test.mocks.dart';

@GenerateMocks([AgendaRepositoryRemoteDataSource, NetworkInfo])
main() {
  late AgendaRepositoryImp agendaRepositoryImp;
  MockAgendaRepositoryRemoteDataSource mockAgendaRepositoryRemoteDataSource =
      MockAgendaRepositoryRemoteDataSource();
  MockNetworkInfo mockNetworkInfo = MockNetworkInfo();

  final agendaHeaders = <AgendaHeader>[
    AgendaHeader(title: 'title', href: '23', entryAmount: '1')
  ];

  setUp(() {
    agendaRepositoryImp = AgendaRepositoryImp(
      agendaRepositoryRemoteDataSource: mockAgendaRepositoryRemoteDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  test('should check device is online', () async {
    // arrange

    when(mockAgendaRepositoryRemoteDataSource.getAgendaHeaders())
        .thenAnswer((_) async => agendaHeaders);
    when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

    // act
    agendaRepositoryImp.getAgendaHeaders();

    // assert
    verify(mockNetworkInfo.isConnected);
  });
}
