import '../../../../core/model/base_agenda_header.dart';

class DebeHeader extends BaseHeader {
  DebeHeader({
    required String title,
    required String href,
  }) : super(
          href: href,
          title: title,
        );

  @override
  List<Object?> get props => [title, href];
}
