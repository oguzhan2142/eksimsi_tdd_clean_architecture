import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:eksimsi_tdd_clean_architecture/core/constants/error_messages.dart';
import 'package:eksimsi_tdd_clean_architecture/core/error/failures.dart';
import 'package:eksimsi_tdd_clean_architecture/core/usecases/usecase.dart';
import 'package:eksimsi_tdd_clean_architecture/features/agenda/domain/entities/agenda_header.dart';
import 'package:eksimsi_tdd_clean_architecture/features/agenda/domain/usecases/get_agenda_headers.dart';
import 'package:equatable/equatable.dart';

part 'headers_event.dart';
part 'headers_state.dart';

class HeadersBloc extends Bloc<HeadersEvent, HeadersState> {
  final GetAgendaHeaders getAgendaHeaders;

  HeadersBloc({required this.getAgendaHeaders}) : super(HeadersInitial());

  @override
  Stream<HeadersState> mapEventToState(
    HeadersEvent event,
  ) async* {
    if (event is GetAgendaHeadersEvent) {
      yield* mapGetAgendaHeadersEventToState();
    }
  }

  Stream<HeadersState> mapGetAgendaHeadersEventToState() async* {
    yield GetAgendaHeadersInProgress();
    final failureOrHeaders = await getAgendaHeaders(NoParams());

    yield failureOrHeaders.fold(
      (l) {
        late final message;

        if (l is NoInternetFailure) {
          message = NO_INTERNET_MESSAGE;
        } else if (l is ServerFailure) {
          message = SERVER_ERROR_MESSAGE;
        } else {
          message = UNEXPECTED_ERROR_MESSAGE;
        }

        return GetAgendaHeadersFailed(message: message);
      },
      (r) => GetAgendaHeadersCompleted(headers: r),
    );

    yield GetAgendaHeadersFailed(message: NO_INTERNET_MESSAGE);
  }
}
