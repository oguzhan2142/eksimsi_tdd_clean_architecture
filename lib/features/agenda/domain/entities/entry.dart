import 'package:eksimsi_tdd_clean_architecture/core/model/base_content.dart';
import 'package:eksimsi_tdd_clean_architecture/core/model/base_entry.dart';

class Entry extends BaseEntry {
  Entry({
    required final String author,
    required final List<Content> contents,
    required final String date,
    required final String entryId,
    required final int favouriteCount,
  }) : super(
          author: author,
          contents: contents,
          date: date,
          entryId: entryId,
          favouriteCount: favouriteCount,
        );

  @override
  List<Object?> get props => [author, contents, date, entryId, favouriteCount];
}
