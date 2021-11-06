import 'package:eksimsi_tdd_clean_architecture/features/agenda/data/extractors/entry_page_extractor.dart';
import 'package:eksimsi_tdd_clean_architecture/core/model/show_all.dart';
import 'package:eksimsi_tdd_clean_architecture/features/agenda/data/models/entry_model.dart';
import 'package:eksimsi_tdd_clean_architecture/features/agenda/domain/entities/entries_page.dart';
import 'package:html/dom.dart';
import 'entry_page_href_model.dart';

class AgendaEntriesPageModel extends EntriesPage {
  AgendaEntriesPageModel({
    required String allHref,
    required String todayHref,
    required String header,
    required int? page,
    required int? totalPage,
    required List<EntryModel> entires,
    required ShowAll? showAll,
    required String rawHref,
  }) : super(
          allHref: allHref,
          entries: entires,
          header: header,
          page: page,
          showAll: showAll,
          todayHref: todayHref,
          totalPage: totalPage,
          entryPageHref: EntryPageHrefModel(rawHref: rawHref),
        );

  factory AgendaEntriesPageModel.fromBody(
      {required Element body, required String rawHref}) {
    final extractor = EntryPageExtractor(body: body);

    int? page = extractor.extractCurrentPage();
    int? totalPage = extractor.extractTotalPage();
    String? allHref = extractor.extractAllHref();
    String? todayHref = extractor.extractTodayHref();
    String header = extractor.extractHeader();
    final entries = extractor.extractEntries();
    ShowAll? showAll = extractor.extractShowAll();


    return AgendaEntriesPageModel(
      rawHref: rawHref,
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
