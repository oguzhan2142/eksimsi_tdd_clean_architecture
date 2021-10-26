import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:eksimsi_tdd_clean_architecture/core/constants/error_messages.dart';
import 'package:eksimsi_tdd_clean_architecture/core/error/failures.dart';
import 'package:eksimsi_tdd_clean_architecture/core/usecases/usecase.dart';
import 'package:eksimsi_tdd_clean_architecture/features/agenda/domain/entities/entries_page.dart';
import 'package:eksimsi_tdd_clean_architecture/features/agenda/domain/usecases/get_agenda_entries_page.dart';
import 'package:equatable/equatable.dart';

part 'entry_page_event.dart';
part 'entry_page_state.dart';

class EntryPageBloc extends Bloc<EntryPageEvent, EntryPageState> {
  final GetAgendaEntriesPage getAgendaEntriesPage;

  EntryPageBloc({required this.getAgendaEntriesPage})
      : super(EntryPageInitial());

  @override
  Stream<EntryPageState> mapEventToState(
    EntryPageEvent event,
  ) async* {
    if (event is GetEntryPageEvent) {
      yield* mapGetEntryPageEventToState(event.pageHref, event.page);
    }
  }

  Stream<EntryPageState> mapGetEntryPageEventToState(String href,int?page) async* {
    yield GetEntryPageInProgress();

    final failureOrEntriesPage = await getAgendaEntriesPage(href,page);

    yield failureOrEntriesPage.fold(
      (l) {
        var message = UNEXPECTED_ERROR_MESSAGE;
        if (l is NoInternetFailure) {
          message = NO_INTERNET_MESSAGE;
        } else if (l is ServerFailure) {
          message = ENTRIES_PAGE_ERROR_MESSAGE;
        }

        return GetEntryPageFailed(message: message);
      },
      (r) => GetEntryPageCompleted(entriesPage: r),
    );
  }
}
