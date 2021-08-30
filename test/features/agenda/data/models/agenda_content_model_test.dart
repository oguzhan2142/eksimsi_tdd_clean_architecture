import 'package:eksimsi_tdd_clean_architecture/core/model/base_content.dart';
import 'package:eksimsi_tdd_clean_architecture/features/agenda/data/models/agenda_content_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:html/dom.dart';

import '../../../../fixtures/fixture_reader.dart';

main() {
  group('BrContentModel', () {
    test('should be a Content', () {
      // arrange
      final model = AgendaBrContentModel();
      // assert
      expect(model, isA<Content>());
    });
  });

  group('InnerLinkContentModel', () {
  
    AgendaInnerLinkContentModel actualInnerLinkContent =
        AgendaInnerLinkContentModel(
            href:
                '/?q=ne+vereyim+abime',
            text: 'ne vereyim abime');

    test('should be a content', () {
      // assert
      expect(actualInnerLinkContent, isA<Content>());
    });

    test(
        'should return valid AgendaInnerLinkContentModel when call fromNode method',
        () {
      // arrange
      final node = _readLinkNode('inner_link_content.html');
      // act
      final contentModel = AgendaInnerLinkContentModel.fromNode(node);
      // assert
      expect(node, isA<Node>());
      expect(actualInnerLinkContent, contentModel);
    });

    test(
        'should return AgendaInnerContentModel with empty string when call fromNode with not existing href attribute',
        () {
      // arrange
      final node = _readLinkNode('inner_link_content.html');

      // act
      node.attributes.remove('href');
      final content = AgendaInnerLinkContentModel.fromNode(node);

      // assert
      expect(node, isA<Node>());
      expect(content.href, '');
    });
  });

  group('OuterLinkContentModel', () {
    final actualOuterLinkContent = AgendaOuterLinkContentModel(
        href: 'https://twitter.com/SiginmaciGundem/status/1423646917544796162?s=19', text: 'kaynak.');

    test('should be a content', () {
      // assert
      expect(actualOuterLinkContent, isA<Content>());
    });

    test(
        'should return valid AgendaOuterLinkContentModel when call fromNode method',
        () {
      // arrange
      final node = _readLinkNode('outer_link_content.html');
      // act
      final contentModel = AgendaOuterLinkContentModel.fromNode(node);
      // assert
      expect(node, isA<Node>());
      expect(actualOuterLinkContent, contentModel);
    });

    test(
        'should return AgendaOuterContentModel with empty string when call fromNode with not existing href attribute',
        () {
      // arrange
      final node = _readLinkNode('outer_link_content.html');

      // act
      node.attributes.remove('href');
      final content = AgendaOuterLinkContentModel.fromNode(node);

      // assert
      expect(node, isA<Node>());
      expect(content.href, '');
    });
  });

  group('TextContentModel', () {
    final content = AgendaTextContentModel(
      text:
          '3. istedikleri yazılımı bulamadılar ya da çok pahalı olduğunu düşündüler',
    );

    test('should be a content', () {
      // assert
      expect(content, isA<Content>());
    });

    test('should return AgendaTextContentModel when call fromNode method', () {
      // arrange
      final doc = fixture('text_content.html');
      final textNode =
          doc.body!.nodes.firstWhere((n) => n.nodeType == Node.TEXT_NODE);

      // act
      final model = AgendaTextContentModel.fromNode(textNode);

      // assert
      expect(textNode, isA<Node>());
      expect(content, model);
    });
  });

  group('SpoilerContentModel', () {
    final content = AgendaSpoilerContentModel(contents: [
      AgendaBrContentModel(),
      AgendaTextContentModel(text: 'text'),
    ]);

    test('should be a content', () {
      // assert
      expect(content, isA<Content>());
    });

    test('should return SpoilerContentModel when call fromNodeList method', () {
      // arrange
      final doc = fixture('spoiler_content.html');
      if (doc.body == null) {
        throw NullThrownError();
      }
      final nodes = doc.body!.nodes;

      

      // act
      final expected = AgendaSpoilerContentModel.fromNodeList(nodes);

      // assert

      expect(13, expected.contents.length);
    });
  });
}

Node _readLinkNode(String fileName) {
  final innerLinkDocument = fixture(fileName);

  final elements = innerLinkDocument.getElementsByTagName('a');

  return elements.first;
}
