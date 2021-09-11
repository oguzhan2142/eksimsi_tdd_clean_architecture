import 'package:eksimsi_tdd_clean_architecture/core/error/exception.dart';
import 'package:eksimsi_tdd_clean_architecture/core/model/show_all.dart';
import 'package:eksimsi_tdd_clean_architecture/features/agenda/data/models/entry_model.dart';
import 'package:html/dom.dart';

class EntryPageExtractor {
  final Element body;

  EntryPageExtractor({required this.body});

  int? extractCurrentPage() {
    Element pagerDiv = _getPagerDiv();
    final currentPageStr = pagerDiv.attributes['data-currentpage'];
    int? page = currentPageStr != null ? int.parse(currentPageStr) : null;
    return page;
  }

  int? extractTotalPage() {
    final dataPageCountStr = _getPagerDiv().attributes['data-pagecount'];
    int? totalPage =
        dataPageCountStr != null ? int.parse(dataPageCountStr) : null;
    return totalPage;
  }

  String extractAllHref() {
    try {
      return _extractNiceHref('tümü');
    } on StateError {
      throw ServerException();
    }
  }

  String extractTodayHref() {
    try {
      return _extractNiceHref('bugün');
    } on StateError {
      throw ServerException();
    }
  }

  String extractHeader() {
    final spans = body.getElementsByTagName('span');
    final titleSpan =
        spans.firstWhere((element) => element.attributes['itemprop'] == 'name');

    String header = titleSpan.text;
    return header;
  }

  List<EntryModel> extractEntries() {
    final allUlTags = body.getElementsByTagName('ul');

    Element? ulTag;
    for (var item in allUlTags) {
      if (item.attributes['id'] == 'entry-item-list') {
        ulTag = item;
        break;
      }
    }
    if (ulTag == null) {
      throw ServerException();
    }

    final allEntryLiTags = ulTag.getElementsByTagName('li');

    final entries = <EntryModel>[];

    allEntryLiTags.forEach((element) {
      entries.add(EntryModel.fromLiTag(element));
    });

    return entries;
  }

  ShowAll extractShowAll() {
    return ShowAll(href: '', text: '');
  }

  String _extractNiceHref(String elementText) {
    final niceModeDiv = body.getElementsByClassName('nice-mode-toggler').first;
    final aTags = niceModeDiv.getElementsByTagName('a');

    try {
      final todayATag =
          aTags.firstWhere((element) => element.text.trim() == elementText);
      if (todayATag.attributes['href'] == null) {
        throw ServerException();
      }

      return todayATag.attributes['href']!;
    } on StateError {
      throw ServerException();
    }
  }

  Element _getPagerDiv() {
    final pagerDiv = body.getElementsByClassName('pager').first;
    return pagerDiv;
  }
}
