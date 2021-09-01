
import 'package:eksimsi_tdd_clean_architecture/core/model/show_all.dart';
import 'package:eksimsi_tdd_clean_architecture/features/agenda/data/models/entry_model.dart';
import 'package:eksimsi_tdd_clean_architecture/features/agenda/domain/entities/entries_page.dart';
import 'package:html/dom.dart';

class AgendaEntriesPageModel extends EntriesPage {
  AgendaEntriesPageModel({
    required String allHref,
    required String todayHref,
    required String header,
    required int page,
    required int totalPage,
    required List<EntryModel> entires,
    required ShowAll? showAll,
  }) : super(
          allHref: allHref,
          entries: entires,
          header: header,
          page: page,
          showAll: showAll,
          todayHref: todayHref,
          totalPage: totalPage,
        );

  factory AgendaEntriesPageModel.fromBody(Element body) {
    // throw ServerException();

    return AgendaEntriesPageModel(
      allHref: '',
      showAll: null,
      entires: [],
      header: '',
      page: 0,
      todayHref: '',
      totalPage: 1,
    );
  }
}
