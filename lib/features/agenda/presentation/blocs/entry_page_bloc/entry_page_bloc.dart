import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:eksimsi_tdd_clean_architecture/features/agenda/domain/entities/entries_page.dart';
import 'package:eksimsi_tdd_clean_architecture/features/agenda/domain/usecases/get_agenda_entries_page.dart';
import 'package:equatable/equatable.dart';

part 'entry_page_event.dart';
part 'entry_page_state.dart';

class EntryPageBloc extends Bloc<EntryPageEvent, EntryPageState> {

  final GetAgendaEntriesPage getAgendaEntriesPage;

  EntryPageBloc({required this.getAgendaEntriesPage}) : super(EntryPageInitial());

  @override
  Stream<EntryPageState> mapEventToState(
    EntryPageEvent event,
  ) async* {
    

    
  }
}
