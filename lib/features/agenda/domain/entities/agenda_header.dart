import 'package:eksimsi_tdd_clean_architecture/core/model/base_agenda_header.dart';

class AgendaHeader extends BaseHeader {
  final String entryAmount;

  AgendaHeader({
    required String title,
    required String href,
    required this.entryAmount,
  }) : super(
          title: title,
          href: href,
        );

  @override
  List<Object?> get props => [title, href, entryAmount];
}
