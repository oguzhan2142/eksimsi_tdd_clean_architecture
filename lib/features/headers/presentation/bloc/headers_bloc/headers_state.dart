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

  const GetAgendaHeadersCompleted({required this.headers});
}

class GetAgendaHeadersFailed extends HeadersState {
  final String message;

  const GetAgendaHeadersFailed({required this.message});

  @override
  List<Object> get props => [message];
}

class GetChannelsHeadersInProgress extends HeadersState {}

class GetChannelHeadersCompleted extends HeadersState {
  final List<ChannelHeader> headers;

  const GetChannelHeadersCompleted({required this.headers});

  @override
  List<Object> get props => [headers];
}

class GetChannelHeadersError extends HeadersState {
  final String message;

  const GetChannelHeadersError({required this.message});

  @override
  List<Object> get props => [message];
}
