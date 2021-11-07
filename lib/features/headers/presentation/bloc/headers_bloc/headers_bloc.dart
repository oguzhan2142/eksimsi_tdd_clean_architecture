import 'dart:async';

import 'package:bloc/bloc.dart';
import '../../../../../core/constants/error_messages.dart';
import '../../../../../core/error/failures.dart';
import '../../../../headers/domain/entities/header.dart';
import '../../../../headers/domain/usecases/get_headers.dart';
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
    final failureOrHeaders = await getAgendaHeaders();

    yield failureOrHeaders.fold(
      (l) {
        late final String message;

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
  }
}
