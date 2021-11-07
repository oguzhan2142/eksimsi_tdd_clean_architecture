import 'package:eksimsi_tdd_clean_architecture/core/model/base_agenda_header.dart';
import 'package:equatable/equatable.dart';

class ChannelHeader extends BaseHeader {
  final String subTitle;

  ChannelHeader({
    required String title,
    required String href,
    required this.subTitle,
  }) : super(
          href: href,
          title: title,
        );

  @override
  List<Object?> get props => [title, subTitle, href];
}
