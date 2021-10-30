import 'package:dartz/dartz.dart';
import 'package:eksimsi_tdd_clean_architecture/core/constants/error_messages.dart';
import 'package:eksimsi_tdd_clean_architecture/core/error/failures.dart';
import 'package:eksimsi_tdd_clean_architecture/features/agenda/domain/entities/entries_page.dart';
import 'package:eksimsi_tdd_clean_architecture/features/agenda/domain/entities/entry_page_href.dart';
import 'package:eksimsi_tdd_clean_architecture/features/agenda/domain/usecases/get_agenda_entries_page.dart';
import 'package:eksimsi_tdd_clean_architecture/features/agenda/presentation/blocs/entry_page_bloc/entry_page_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'entries_page_bloc_test.mocks.dart';

@GenerateMocks([GetAgendaEntriesPage])
main() {
  late MockGetAgendaEntriesPage getAgendaEntriesPage;
  late EntryPageBloc bloc;

  setUp(() {
    getAgendaEntriesPage = MockGetAgendaEntriesPage();
    bloc = EntryPageBloc(getAgendaEntriesPage: getAgendaEntriesPage);
  });

  test('initialState should be [EntryPageInitial]', () {
    // assert
    expect(bloc.state, EntryPageInitial());
  });

  group('GetAgendaEntriesPage', () {
    late EntriesPage entriesPage;

    setUp(() {
      entriesPage = EntriesPage(
        page: 1,
        totalPage: 3,
        allHref: 'allHref',
        header: 'header',
        showAll: null,
        todayHref: 'todayHref',
        entries: [],
        entryPageHref: EntryPageHref(),
      );
    });

    test('should emit [GetHeadersError] when no internet connection', () {
      // arrange
      when(getAgendaEntriesPage(any,any))
          .thenAnswer((_) => Future.value(Left(NoInternetFailure())));

      final expected = [
        GetEntryPageInProgress(),
        GetEntryPageFailed(message: NO_INTERNET_MESSAGE),
      ];
      // assert
      expectLater(bloc.stream, emitsInOrder(expected));

      // act
      bloc.add(GetEntryPageEvent(pageHref: ''));
    });

    test(
        'should emit [GetHeadersError] when error while getting data from source',
        () {
      when(getAgendaEntriesPage(any,any))
          .thenAnswer((_) => Future.value(Left(ServerFailure())));

      final expected = [
        GetEntryPageInProgress(),
        GetEntryPageFailed(message: ENTRIES_PAGE_ERROR_MESSAGE),
      ];
      // assert
      expectLater(bloc.stream, emitsInOrder(expected));

      // act
      bloc.add(GetEntryPageEvent(pageHref: ''));
    });

    test('should emit [GetHeadersCompleted] when get data successfully', () {
      // arrange
      when(getAgendaEntriesPage(any,any))
          .thenAnswer((_) => Future.value(Right(entriesPage)));

      // assert
      final expected = [
        GetEntryPageInProgress(),
        GetEntryPageCompleted(entriesPage: entriesPage),
      ];

      expectLater(bloc.stream, emitsInOrder(expected));

      // act
      bloc.add(GetEntryPageEvent(pageHref: ''));
    });
  });
}
