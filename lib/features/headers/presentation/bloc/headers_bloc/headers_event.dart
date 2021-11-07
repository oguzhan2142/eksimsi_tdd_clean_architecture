part of 'headers_bloc.dart';

abstract class HeadersEvent extends Equatable {
  const HeadersEvent();

  @override
  List<Object> get props => [];
}

class GetAgendaHeadersEvent extends HeadersEvent {
  final String href;  

  const GetAgendaHeadersEvent({
    required this.href,
  });

  @override
  List<Object> get props => [href];
}

class GetChannelsHeadersEvent extends HeadersEvent {}
