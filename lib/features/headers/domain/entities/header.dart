import 'package:eksimsi_tdd_clean_architecture/core/model/base_agenda_header.dart';

class Header extends BaseHeader {
  final String entryAmount;

  Header({
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
