import 'dart:async';

import 'package:eksimsi_tdd_clean_architecture/core/parameters/href_page_parameter.dart';
import 'package:eksimsi_tdd_clean_architecture/features/headers/domain/usecases/get_channel_headers.dart';
import 'package:eksimsi_tdd_clean_architecture/features/headers/presentation/bloc/headers_bloc/headers_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants/error_messages.dart';
import '../../../../../core/error/failures.dart';
import '../../../domain/entities/entries_page.dart';
import '../../../domain/usecases/get_agenda_entries_page.dart';

part 'entry_page_event.dart';
part 'entry_page_state.dart';

class EntryPageBloc extends Bloc<EntryPageEvent, EntryPageState> {
  final GetAgendaEntriesPage getAgendaEntriesPage;

  EntryPageBloc({required this.getAgendaEntriesPage})
      : super(EntryPageInitial()) {
    on<GetEntryPageEvent>(
      (event, emit) => mapGetEntryPageEventToState(event, emit),
    );
 
  }

  Future<void> mapGetEntryPageEventToState(
    GetEntryPageEvent event,
    Emitter<EntryPageState> emit,
  ) async {
    emit(GetEntryPageInProgress());

    final parameter =
        HrefPageParameter(href: event.pageHref, page: event.page);
    final failureOrEntriesPage =
        await getAgendaEntriesPage(parameter: parameter);

    final result = failureOrEntriesPage.fold(
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

    emit(result);
  }
}
