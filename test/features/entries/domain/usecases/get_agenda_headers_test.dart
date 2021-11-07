
import 'package:dartz/dartz.dart';
import 'package:eksimsi_tdd_clean_architecture/features/entries/domain/entities/header.dart';
import 'package:eksimsi_tdd_clean_architecture/features/entries/domain/repositories/agenda_repository.dart';
import 'package:eksimsi_tdd_clean_architecture/features/entries/domain/usecases/get_agenda_headers.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_agenda_headers_test.mocks.dart';



@GenerateMocks([AgendaRepository])
void main() {
  late GetAgendaHeaders usecase;
  late MockAgendaRepository mockAgendaRepository;

  setUp(() {
    mockAgendaRepository = MockAgendaRepository();
    usecase = GetAgendaHeaders(mockAgendaRepository);
  });

  final agendaHeaders = <Header>[
    Header(title: 'test', href: 'test href', entryAmount: '1'),
  ];

  test('should call agenda_repository when execute usecase', () async {
    when(mockAgendaRepository.getHeaders())
        .thenAnswer((_) async => Right(agendaHeaders));

    final result = await usecase();

   

    expect(result, Right(agendaHeaders));
    verify(mockAgendaRepository.getHeaders());
    verifyNoMoreInteractions(mockAgendaRepository);
  });
}
