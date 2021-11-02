import 'package:eksimsi_tdd_clean_architecture/features/channels/domain/entities/channel_header.dart';
import 'package:html/dom.dart';

class ChannelHeaderModel extends ChannelHeader {
  ChannelHeaderModel({
    required String href,
    required String subTitle,
    required String title,
  }) : super(href: href, subTitle: subTitle, title: title);

  factory ChannelHeaderModel.fromLi({
    required Element element,
  }) {
    throw UnimplementedError();
  }
}
