import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:eksimsi_tdd_clean_architecture/core/parameters/get_agenda_entry_page_parameter.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/constants/error_messages.dart';
import '../../../../../core/error/failures.dart';
import '../../../domain/entities/entries_page.dart';
import '../../../domain/usecases/get_agenda_entries_page.dart';


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

  Stream<EntryPageState> mapGetEntryPageEventToState(
    String href,
    int? page,
  ) async* {
    yield GetEntryPageInProgress();

    final parameter = GetAgendaEntriesPageParameter(href: href, page: page);
    final failureOrEntriesPage =
        await getAgendaEntriesPage(parameter: parameter);

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
