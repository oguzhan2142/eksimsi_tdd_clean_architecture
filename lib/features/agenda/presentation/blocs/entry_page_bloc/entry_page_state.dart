part of 'entry_page_bloc.dart';

abstract class EntryPageState extends Equatable {
  const EntryPageState();

  @override
  List<Object> get props => [];
}

class EntryPageInitial extends EntryPageState {}

class GetEntryPageInProgress extends EntryPageState {}

class GetEntryPageFailed extends EntryPageState {
  final String message;

  GetEntryPageFailed({required this.message});

  @override
  List<Object> get props => [message];
}

class GetEntryPageCompleted extends EntryPageState {
  final EntriesPage entriesPage;

  GetEntryPageCompleted({required this.entriesPage});

  @override
  List<Object> get props => [entriesPage];
}
