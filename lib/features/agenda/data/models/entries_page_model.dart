import 'package:eksimsi_tdd_clean_architecture/core/extractors/entry_page_extractor.dart';
import 'package:eksimsi_tdd_clean_architecture/core/model/show_all.dart';
import 'package:eksimsi_tdd_clean_architecture/features/agenda/data/models/entry_model.dart';
import 'package:eksimsi_tdd_clean_architecture/features/agenda/domain/entities/entries_page.dart';
import 'package:html/dom.dart';

class AgendaEntriesPageModel extends EntriesPage {
  AgendaEntriesPageModel({
    required String allHref,
    required String todayHref,
    required String header,
    required int? page,
    required int? totalPage,
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
    final extractor = EntryPageExtractor(body: body);

    int? page = extractor.extractCurrentPage();
    int? totalPage = extractor.extractTotalPage();
    String? allHref = extractor.extractAllHref();
    String? todayHref = extractor.extractTodayHref();
    String header = extractor.extractHeader();
    final entries = extractor.extractEntries();
    ShowAll? showAll = extractor.extractShowAll();

    return AgendaEntriesPageModel(
      allHref: allHref,
      showAll: showAll,
      entires: entries,
      header: header,
      page: page,
      todayHref: todayHref,
      totalPage: totalPage,
    );
  }
}
