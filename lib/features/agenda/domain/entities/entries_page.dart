import 'package:eksimsi_tdd_clean_architecture/core/model/base_entries_page.dart';
import 'package:eksimsi_tdd_clean_architecture/core/model/show_all.dart';

import 'agenda_entry.dart';

class AgendaEntriesPage extends BaseEntriesPage {
  AgendaEntriesPage({
    required int page,
    required int totalPage,
    required String allHref,
    required String header,
    required ShowAll? showAll,
    required String todayHref,
    required List<AgendaEntry> entries,
  }) : super(
          page: page,
          totalPage: totalPage,
          allHref: allHref,
          header: header,
          showAll: showAll,
          todayHref: todayHref,
          entries: entries,
        );

  @override
  List<Object?> get props =>
      [page, totalPage, allHref, header, showAll, todayHref];
}
