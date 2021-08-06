import 'package:eksimsi_tdd_clean_architecture/core/model/base_entry.dart';

class AgendaEntry extends BaseEntry {
  AgendaEntry({
    required final String author,
    required final String content,
    required final String date,
    required final String entryId,
    required final int favouriteCount,
  }) : super(
          author: author,
          content: content,
          date: date,
          entryId: entryId,
          favouriteCount: favouriteCount,
        );

  @override
  List<Object?> get props => [author, content, date, entryId, favouriteCount];
}
