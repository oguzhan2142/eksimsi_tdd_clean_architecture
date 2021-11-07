part of 'headers_bloc.dart';

abstract class HeadersEvent extends Equatable {
  const HeadersEvent();

  @override
  List<Object> get props => [];
}

class GetAgendaHeadersEvent extends HeadersEvent {}

class GetChannelsHeadersEvent extends HeadersEvent {}
