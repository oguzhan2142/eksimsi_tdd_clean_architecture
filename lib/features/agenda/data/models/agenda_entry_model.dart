import 'package:eksimsi_tdd_clean_architecture/features/agenda/data/models/agenda_content_model.dart';
import 'package:eksimsi_tdd_clean_architecture/features/agenda/domain/entities/agenda_entry.dart';
import 'package:html/dom.dart';

class AgendaEntryModel extends AgendaEntry {
  AgendaEntryModel({
    required String author,
    required List<AgendaContentModel> agendaContents,
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
    return AgendaEntryModel(
      author: 'author',
      agendaContents: [],
      date: 'date',
      entryId: 'entryId',
      favouriteCount: 1,
    );
  }
}
