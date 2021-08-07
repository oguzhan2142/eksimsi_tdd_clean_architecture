import 'package:eksimsi_tdd_clean_architecture/core/model/base_content.dart';

import 'package:html/dom.dart';

/* 
  inner link - class = 'b'
  outer link - class = 'url'
  spoiler (a taglarindan bazilari spoiler linki veriyor) class = 'b'
  br
  text


 */

class AgendaBrContentModel extends BrContent {}

class AgendaSpoilerContentModel extends SpoilerContent {
  AgendaSpoilerContentModel({
    required List<Content> contents,
  }) : super(
          contents: contents,
        );
}

class AgendaTextContentModel extends TextContent {
  AgendaTextContentModel({
    required String text,
  }) : super(
          text: text,
        );
}

class AgendaInnerLinkContentModel extends InnerLinkContent {
  AgendaInnerLinkContentModel({
    required String href,
    required String text,
  }) : super(
          href: href,
          text: text,
        );

  factory AgendaInnerLinkContentModel.fromNode(Node node) {
    final href = node.attributes['href'] == null ? '' : node.attributes['href'];

    final text = node.text != null ? node.text!.trim() : '';

    return AgendaInnerLinkContentModel(href: href!, text: text);
  }
}

class AgendaOuterLinkContentModel extends OuterLinkContent {
  AgendaOuterLinkContentModel({
    required String href,
    required String text,
  }) : super(
          href: href,
          text: text,
        );
}
