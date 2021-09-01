import 'package:eksimsi_tdd_clean_architecture/core/model/base_content.dart';
import 'package:eksimsi_tdd_clean_architecture/core/model/content_extractor.dart';

import 'package:eksimsi_tdd_clean_architecture/features/agenda/domain/entities/entry.dart';
import 'package:html/dom.dart';

class EntryModel extends Entry {
  EntryModel({
    required String author,
    required List<Content> agendaContents,
    required String date,
    required String entryId,
    required int favouriteCount,
  }) : super(
          author: author,
          contents: agendaContents,
          date: date,
          entryId: entryId,
          favouriteCount: favouriteCount,
        );

  factory EntryModel.fromLiTag(Element liTag) {
    final extractor = ContentExtractor();
    final contentsDiv = liTag.getElementsByClassName('content content-expanded').first;
    final contents = extractor.extract(contentsDiv.nodes);

    final id = liTag.attributes['data-id'] ?? '';
    final author = liTag.attributes['data-author'] ?? '';
    final favourite = int.parse(liTag.attributes['data-favorite-count'] ?? '0');
    final date =
        liTag.getElementsByClassName('entry-date permalink').first.text;

    return EntryModel(
      author: author,
      agendaContents: contents,
      date: date,
      entryId: id,
      favouriteCount: favourite,
    );
  }
}
