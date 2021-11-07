import 'package:eksimsi_tdd_clean_architecture/core/model/show_all.dart';

import 'package:eksimsi_tdd_clean_architecture/features/entries/data/extractors/entry_page_extractor.dart';
import 'package:eksimsi_tdd_clean_architecture/features/entries/domain/entities/entries_page.dart';
import 'package:html/dom.dart';

import 'entry_model.dart';
import 'entry_page_href_model.dart';

class EntriesPageModel extends EntriesPage {
  EntriesPageModel({
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

  factory EntriesPageModel.fromBody(
      {required Element body, required String rawHref}) {
    final extractor = EntryPageExtractor(body: body);

    final int? page = extractor.extractCurrentPage();
    final int? totalPage = extractor.extractTotalPage();
    final String allHref = extractor.extractAllHref();
    final String todayHref = extractor.extractTodayHref();
    final String header = extractor.extractHeader();
    final entries = extractor.extractEntries();
    final ShowAll? showAll = extractor.extractShowAll();


    return EntriesPageModel(
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
