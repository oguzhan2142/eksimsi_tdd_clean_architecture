import 'package:eksimsi_tdd_clean_architecture/core/error/exception.dart';
import 'package:eksimsi_tdd_clean_architecture/features/headers/domain/entities/channel_header.dart';
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
    try {
      final aElement = element.getElementsByClassName('a').first;

      final String href = aElement.attributes['href'] ?? '';
      final String subTitle = aElement.attributes['title'] ?? '';

      final String title = aElement.text;

      return ChannelHeaderModel(
        href: href,
        subTitle: subTitle,
        title: title,
      );
    } catch (e) {
      throw ModelConversionException();
    }
  }
}
