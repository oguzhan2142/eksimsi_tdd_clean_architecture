import 'package:dartz/dartz.dart';
import 'package:eksimsi_tdd_clean_architecture/core/error/failures.dart';
import 'package:eksimsi_tdd_clean_architecture/core/parameters/href_page_parameter.dart';
import 'package:eksimsi_tdd_clean_architecture/features/entries/domain/entities/entries_page.dart';
import 'package:eksimsi_tdd_clean_architecture/features/entries/domain/entities/entry_page_href.dart';
import 'package:eksimsi_tdd_clean_architecture/features/entries/domain/repositories/entries_repository.dart';
import 'package:eksimsi_tdd_clean_architecture/features/entries/domain/usecases/get_agenda_entries_page.dart';
import 'package:eksimsi_tdd_clean_architecture/features/headers/domain/repositories/headers_repository.dart';




import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';



import 'get_agenda_entries_page_test.mocks.dart';





@GenerateMocks([EntriesRepository,GetAgendaEntriesPage])
void main() {
  late final  repository = MockEntriesRepository();
  late final GetAgendaEntriesPage useCase =
      GetAgendaEntriesPage(repository);

  final EntriesPage agendaEntriesPage = EntriesPage(
    page: 1,
    totalPage: 2,
    allHref: 'jref',
    header: 'test header',
    showAll: null,
    todayHref: 'todayHref',
    entries: const [],
    entryPageHref: EntryPageHref(),
  );

final param = HrefPageParameter(href: '');

  Future<Either<Failure, EntriesPage>> _arrangeAndAct(
    EntriesPage data,
  ) async {
    // arrange
    when(repository.getAgendaEntriesPage(any,any))
        .thenAnswer((_) async => Right(agendaEntriesPage));
    // act
    
    final result = await useCase(parameter: param);
    return result;
  }

  test('should call agenda_repository when execute usecase', () async {
    final result = await _arrangeAndAct(agendaEntriesPage);
    // assert
    expect(result, Right(agendaEntriesPage));
    verify(repository.getAgendaEntriesPage(any,any));
    verifyNoMoreInteractions(repository);
  });

  // test('should return failure when total page greater than page', () async {
  //   // arrange
  //   final result = _arrangeAndAct(agendaEntriesPageWithWrongPageNumber);

  //   // assert
  //   expect(result, isA<Failure>());
  // });
}
