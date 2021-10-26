part of 'entry_page_bloc.dart';

abstract class EntryPageEvent extends Equatable {
  const EntryPageEvent();

  @override
  List<Object> get props => [];
}

class GetEntryPageEvent extends EntryPageEvent {
  final String pageHref;
  final int? page;

  GetEntryPageEvent({required this.pageHref, this.page});

  @override
  List<Object> get props => [pageHref];
}
