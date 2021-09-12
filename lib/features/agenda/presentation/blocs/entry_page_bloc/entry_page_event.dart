part of 'entry_page_bloc.dart';

abstract class EntryPageEvent extends Equatable {
  const EntryPageEvent();

  @override
  List<Object> get props => [];
}

class GetEntryPageEvent extends EntryPageEvent {
  final String pageHref;

  GetEntryPageEvent({required this.pageHref});

  @override
  List<Object> get props => [pageHref];
}
