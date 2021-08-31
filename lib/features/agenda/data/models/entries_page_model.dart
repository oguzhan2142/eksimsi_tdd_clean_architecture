import 'package:eksimsi_tdd_clean_architecture/core/model/show_all.dart';
import 'package:eksimsi_tdd_clean_architecture/features/agenda/data/models/entry_model.dart';
import 'package:eksimsi_tdd_clean_architecture/features/agenda/domain/entities/entries_page.dart';

class AgendaEntriesPageModel extends AgendaEntriesPage {
  AgendaEntriesPageModel({
    required String allHref,
    required String header,
    required int page,
    required int totalPage,
    required List<EntryModel> entires,
    required ShowAll showAll,
    required String todayHref,
  }) : super(
          allHref: allHref,
          entries: entires,
          header: header,
          page: page,
          showAll: showAll,
          todayHref: todayHref,
          totalPage: totalPage,
        );
}
