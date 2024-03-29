
import 'package:eksimsi_tdd_clean_architecture/features/headers/domain/entities/header.dart';
import 'package:html/dom.dart';

class HeaderModel extends Header {
  HeaderModel({
    required String title,
    required String href,
    required String entryAmount,
  }) : super(
          title: title,
          href: href,
          entryAmount: entryAmount,
        );

  Map<String, dynamic> toJson() {
    return {
      'title':title,
      'href':href,
      'entryAmount':entryAmount,
    };
  }

  factory HeaderModel.fromLiTag(Element liElement) {
    final aTag = liElement.getElementsByTagName('a').first;
    final entryAmount = aTag.getElementsByTagName('small').first.text.trim();

    late final String href;
    if (aTag.attributes['href'] != null) {
      href = aTag.attributes['href']!.trim();
    } else {
      href = '';
    }

    late final String title;
    if (aTag.children.isNotEmpty) {
      title = aTag.firstChild!.text!.trim();
    } else {
      title = '';
    }

    return HeaderModel(
      title: title,
      href: href,
      entryAmount: entryAmount,
    );
  }
}
