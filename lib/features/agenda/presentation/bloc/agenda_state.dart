part of 'agenda_bloc.dart';
abstract class AgendaState extends Equatable {
  const AgendaState();
}
class AgendaInitial extends AgendaState {
  @override
  List<Object> get props => [];
}
