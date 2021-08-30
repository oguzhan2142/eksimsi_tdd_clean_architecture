import 'package:eksimsi_tdd_clean_architecture/core/model/base_content.dart';
import 'package:eksimsi_tdd_clean_architecture/core/model/content_extractor.dart';

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

  factory AgendaSpoilerContentModel.fromNodeList(NodeList nodeList) {

    final contentExtractor = ContentExtractor();

    contentExtractor.extract(nodeList);


 

    return AgendaSpoilerContentModel(contents: contentExtractor.contents);
  }
}

class AgendaTextContentModel extends TextContent {
  AgendaTextContentModel({
    required String text,
  }) : super(
          text: text,
        );

  factory AgendaTextContentModel.fromNode(Node node) {
    late final text;
    if (node.text != null) {
      text = node.text;
    } else {
      text = '';
    }
    return AgendaTextContentModel(text: text);
  }
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

  factory AgendaOuterLinkContentModel.fromNode(Node node) {
    final href = node.attributes['href'] == null ? '' : node.attributes['href'];

    final text = node.text != null ? node.text!.trim() : '';

    return AgendaOuterLinkContentModel(href: href!, text: text);
  }
}
