import 'package:dartz/dartz.dart';
import 'package:eksimsi_tdd_clean_architecture/core/error/failures.dart';
import 'package:eksimsi_tdd_clean_architecture/core/usecases/usecase.dart';
import 'package:eksimsi_tdd_clean_architecture/features/agenda/domain/entities/entries_page.dart';
import 'package:eksimsi_tdd_clean_architecture/features/agenda/domain/repositories/agenda_repository.dart';
import 'package:eksimsi_tdd_clean_architecture/features/agenda/domain/usecases/get_agenda_entries_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_agenda_headers_test.mocks.dart';

@GenerateMocks([AgendaRepository])
main() {
  late final MockAgendaRepository mockAgendaRepository = MockAgendaRepository();
  late final GetAgendaEntriesPage useCase =
      GetAgendaEntriesPage(mockAgendaRepository);

  final AgendaEntriesPage agendaEntriesPage = AgendaEntriesPage(
    page: 1,
    totalPage: 2,
    allHref: 'jref',
    header: 'test header',
    showAll: null,
    todayHref: 'todayHref',
    entries: [],
  );

  final AgendaEntriesPage agendaEntriesPageWithWrongPageNumber =
      AgendaEntriesPage(
    page: 1,
    totalPage: 2,
    allHref: 'jref',
    header: 'test header',
    showAll: null,
    todayHref: 'todayHref',
    entries: [],
  );

  Future<Either<Failure, AgendaEntriesPage>> _arrangeAndAct(
    AgendaEntriesPage data,
  ) async {
    // arrange
    when(mockAgendaRepository.getAgendaEntriesPage())
        .thenAnswer((_) async => Right(agendaEntriesPage));
    // act
    final result = await useCase.call(NoParams());
    return result;
  }

  test('should call agenda_repository when execute usecase', () async {
    final result = await _arrangeAndAct(agendaEntriesPage);
    // assert
    expect(result, Right(agendaEntriesPage));
    verify(mockAgendaRepository.getAgendaEntriesPage());
    verifyNoMoreInteractions(mockAgendaRepository);
  });

  // test('should return failure when total page greater than page', () async {
  //   // arrange
  //   final result = _arrangeAndAct(agendaEntriesPageWithWrongPageNumber);

  //   // assert
  //   expect(result, isA<Failure>());
  // });
}
