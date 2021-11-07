import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:eksimsi_tdd_clean_architecture/core/parameters/href_parameter.dart';
import 'package:eksimsi_tdd_clean_architecture/core/parameters/no_parameter.dart';
import 'package:eksimsi_tdd_clean_architecture/features/headers/domain/entities/channel_header.dart';
import 'package:eksimsi_tdd_clean_architecture/features/headers/domain/usecases/get_channel_headers.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/constants/error_messages.dart';
import '../../../../../core/error/failures.dart';
import '../../../../headers/domain/entities/header.dart';
import '../../../domain/usecases/get_entries_headers.dart';

part 'headers_event.dart';
part 'headers_state.dart';

class HeadersBloc extends Bloc<HeadersEvent, HeadersState> {
  final GetEntriesHeaders getAgendaHeaders;
  final GetChannelHeaders getChannelHeaders;

  HeadersBloc({
    required this.getAgendaHeaders,
    required this.getChannelHeaders,
  }) : super(HeadersInitial()) {
    on<GetAgendaHeadersEvent>(
      (event, emit) => mapGetAgendaHeadersEventToState(event, emit),
    );

    on<GetChannelsHeadersEvent>(
      (event, emit) => mapGetChannelHeadersEventToState(event, emit),
    );
  }

  Future<void> mapGetAgendaHeadersEventToState(
    GetAgendaHeadersEvent event,
    Emitter<HeadersState> emit,
  ) async {
    emit(GetAgendaHeadersInProgress());
    final failureOrHeaders = await getAgendaHeaders.call(parameter: HrefParameter(href: event.href));

    final result = failureOrHeaders.fold(
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

    emit(result);
  }

  Future<void> mapGetChannelHeadersEventToState(
    GetChannelsHeadersEvent event,
    Emitter<HeadersState> emit,
  ) async {
    emit(GetChannelsHeadersInProgress());

    final failureOrHeaders =
        await getChannelHeaders.call(parameter: NoParameter());

    emit(
      failureOrHeaders.fold(
        (l) {
          if (l is NoInternetFailure) {
            return const GetChannelHeadersError(message: NO_INTERNET_MESSAGE);
          }
          if (l is ServerFailure) {
            return const GetChannelHeadersError(message: SERVER_ERROR_MESSAGE);
          }
          return const GetChannelHeadersError(
            message: UNEXPECTED_ERROR_MESSAGE,
          );
        },
        (r) => GetChannelHeadersCompleted(headers: r),
      ),
    );
  }
}
