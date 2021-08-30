import 'package:eksimsi_tdd_clean_architecture/core/model/base_content.dart';
import 'package:eksimsi_tdd_clean_architecture/features/agenda/data/models/agenda_content_model.dart';
import 'package:eksimsi_tdd_clean_architecture/features/agenda/domain/entities/agenda_entry.dart';
import 'package:html/dom.dart';

class AgendaEntryModel extends AgendaEntry {
  AgendaEntryModel({
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

  factory AgendaEntryModel.fromLiTag(Element liTag) {
    // XXX not implemented yet
    final contents = <Content>[];
    for (var node in liTag.nodes) {
      switch (node.nodeType) {
        case Node.TEXT_NODE:
          if (node.text != null) {
            final text = node.text!.trim();
            contents.add(AgendaTextContentModel(text: text));
          }
          break;
        case Node.ELEMENT_NODE:
          if (node.attributes['class'] == 'url') {
            late final href;
            if (node.attributes['href'] == null) {
              break;
            }

            href = node.attributes['href'];

            final text = node.text != null ? node.text!.trim() : '';
            final content = OuterLinkContent(href: href, text: text);
            contents.add(content);
          } else if (node.attributes['class'] == 'b') {

              

          }

          break;
        default:
      }
    }

    return AgendaEntryModel(
      author: 'author',
      agendaContents: [],
      date: 'date',
      entryId: 'entryId',
      favouriteCount: 1,
    );
  }
}
