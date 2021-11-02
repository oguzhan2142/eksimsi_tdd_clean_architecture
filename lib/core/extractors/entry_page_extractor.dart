import '../error/exception.dart';
import '../model/show_all.dart';
import '../../features/agenda/data/models/entry_model.dart';
import 'package:html/dom.dart';

class EntryPageExtractor {
  final Element body;

  EntryPageExtractor({required this.body});

  int? extractCurrentPage() {
    Element? pagerDiv = _getPagerDiv();

    if (pagerDiv == null) {
      return null;
    }

    final currentPageStr = pagerDiv.attributes['data-currentpage'];
    int? page = currentPageStr != null ? int.parse(currentPageStr) : null;
    return page;
  }

  int? extractTotalPage() {
    final pagerDiv = _getPagerDiv();
    if (pagerDiv == null) return null;
    final dataPageCountStr = pagerDiv.attributes['data-pagecount'];
    int? totalPage =
        dataPageCountStr != null ? int.parse(dataPageCountStr) : null;
    return totalPage;
  }

  String extractAllHref() {
    return _extractNiceHref('tümü');
  }

  String extractTodayHref() {
    return _extractNiceHref('bugün');
  }

  String extractHref() {
    var selector = body.querySelector('#title > a');

    if (selector == null) throw ServerException();

    String? href = selector.attributes['href'];

    if (href == null) {
      throw ServerException();
    }

    return href;
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
    ulTag = body.querySelector('#entry-item-list');
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

  ShowAll? extractShowAll() {
    final nodesWithClassNameShowAll = body.getElementsByClassName('showall');

    try {
      final result = nodesWithClassNameShowAll.firstWhere(
          (element) => element.attributes['title'] == 'tümünü göster');
      final href = result.attributes['href'];

      if (href == null) {
        return null;
      }

      if (href.isEmpty) {
        return null;
      }
      final label = result.text;

      return ShowAll(href: href, text: label);
    } on StateError {
      return null;
    }
  }

  String _extractNiceHref(String elementText) {
    var baseHref = extractHref();

    if (elementText == 'tümü') {
      return baseHref + '?a=nice';
    } else if (elementText == 'bugün') {
      return baseHref + '?a=dailynice';
    }
    return baseHref;
  }

  Element? _getPagerDiv() {
    try {
      final pagerDiv = body.getElementsByClassName('pager').first;
      return pagerDiv;
    } catch (e) {
      return null;
    }
  }
}
