part of 'headers_bloc.dart';

abstract class HeadersState extends Equatable {
  const HeadersState();

  @override
  List<Object> get props => [];
}

class HeadersInitial extends HeadersState {}

class GetAgendaHeadersInProgress extends HeadersState {}

class GetAgendaHeadersCompleted extends HeadersState {
  final List<Header> headers;

  GetAgendaHeadersCompleted({required this.headers});
}

class GetAgendaHeadersFailed extends HeadersState {
  final String message;

  GetAgendaHeadersFailed({required this.message});

  @override
  List<Object> get props => [message];
}
