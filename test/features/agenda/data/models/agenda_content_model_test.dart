
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
                'https://twitter.com/SiginmaciGundem/status/1423646917544796162?s=19',
            text: 'kaynak.');

    test('should be a content', () {
      // assert
      expect(actualInnerLinkContent, isA<Content>());
    });

    test(
        'should return valid AgendaInnerLinkContentModel when call fromNode method',
        () {
      // arrange
      final node = _getInnerLinkNode();
      // act
      final contentModel = AgendaInnerLinkContentModel.fromNode(node);
      // assert
      expect(actualInnerLinkContent, contentModel);
    });

    test(
        'should return AgendaInnerContentModel with empty string when call fromNode with not existing href attribute',
        () {
      // arrange
      final node = _getInnerLinkNode();

      // act
      node.attributes.remove('href');
      final content = AgendaInnerLinkContentModel.fromNode(node);

      // assert
      expect(content.href, '');
    });
  });

  group('OuterLinkContentModel', () {
    final content = AgendaOuterLinkContentModel(href: 'myHref', text: 'linzk');

    test('should be a content', () {
      // assert
      expect(content, isA<Content>());
    });


    
  });

  group('TextContentModel', () {
    final content = AgendaTextContentModel(
      text: 'linzk',
    );

    test('should be a content', () {
      // assert
      expect(content, isA<Content>());
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
  });
}

Node _getInnerLinkNode() {
  final innerLinkDocument = fixture('inner_link_content.html');

  final elements = innerLinkDocument.getElementsByTagName('a');

  return elements.first;
}
