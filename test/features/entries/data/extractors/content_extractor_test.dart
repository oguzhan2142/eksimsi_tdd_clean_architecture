import 'package:eksimsi_tdd_clean_architecture/features/entries/data/extractors/content_extractor.dart';
import 'package:eksimsi_tdd_clean_architecture/features/entries/domain/entities/contents.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:html/dom.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  late ContentExtractor extractor;

  setUp(() {
    extractor = ContentExtractor();
  });

  group('for text contents', () {
    late Document textDocument;

    setUp(() {
      textDocument = fixtureAsDocument('text_content.html');
    });

    test('should return only one TextContent when use text_content.html', () {
      // arrange
      if (textDocument.body == null) {
        assert(false);
      }
      final nodes = textDocument.body!.nodes;

      // act
      final contents = extractor.extract(nodes);

      // assert
      expect(contents.length, 1);
      expect(contents.first, isA<TextContent>());
    });

    test('should return text value when use text_content.html', () {
      // arrange
      if (textDocument.body == null) {
        assert(false);
      }
      final nodes = textDocument.body!.nodes;

      // act
      final contents = extractor.extract(nodes);

      final textContent = contents.first as TextContent;

      // assert
      expect(textContent.text, isNotNull);
    });
  });

  group('for link contents', () {
    late Document innerLinkDocument;
    late Document outerLinkDocument;
    setUp(() {
      outerLinkDocument = fixtureAsDocument('outer_link_content.html');
      innerLinkDocument = fixtureAsDocument('inner_link_content.html');
    });
    test(
        'should return only one innerLinkContent when use inner_link_content.html file',
        () {
      // arrange
      final nodes = innerLinkDocument.body!.nodes;
      if (innerLinkDocument.body == null) {
        assert(false);
      }

      // act
      final contents = extractor.extract(nodes);

      // assert
      expect(contents.length, 1);
      expect(contents.first, isA<InnerLinkContent>());
    });

    test(
        'should return only one outerLinkContent when use outer_link_content.html file',
        () {
      // arrange
      final nodes = outerLinkDocument.body!.nodes;
      if (outerLinkDocument.body == null) {
        assert(false);
      }

      // act
      final contents = extractor.extract(nodes);

      // assert
      expect(contents.length, 1);
      expect(contents.first, isA<OuterLinkContent>());
    });
  });

  group('for spoiler content', () {
    late NodeList nodeListOnlyContainsSpoilerContent;
    setUp(() {
      final spoilerDocument = fixtureAsDocument('spoiler_content.html');

      nodeListOnlyContainsSpoilerContent =
          spoilerDocument.getElementsByTagName('body').first.nodes;
    });
    group('when use spoiler_content.html file', () {
      test('should return only one spoiler content', () {
        // act
        final lenght =
            extractor.extract(nodeListOnlyContainsSpoilerContent).length;

        // assert
        expect(lenght, 1);
      });

      test('should not contains any spoiler text inside nodes', () {
        // arrange
        final contents = extractor.extract(nodeListOnlyContainsSpoilerContent);
        final spoiler = contents.first as SpoilerContent;

        // act
        final result = spoiler.contents.where((element) {
          if (element is TextContent) {
            return element.text == 'spoiler';
          } else if (element is InnerLinkContent) {
            return element.text == 'spoiler';
          } else if (element is OuterLinkContent) {
            return element.text == 'spoiler';
          }

          return false;
        });

        // assert
        expect(result.length, 0);
      });

      test(
          "should return spoiler content with nodelist which hasn't any inner_link_content",
          () {
        // act
        final content = extractor
            .extract(nodeListOnlyContainsSpoilerContent)
            .first as SpoilerContent;

        final nodes = content.contents;

        final innerLinks = nodes.whereType<InnerLinkContent>();
        // assert
        expect(innerLinks.length, 0);
      });

      test('should return spoiler content with nodelist which has 9 br content',
          () {
        // act
        final content = extractor
            .extract(nodeListOnlyContainsSpoilerContent)
            .first as SpoilerContent;

        final brContents =
            content.contents.whereType<BrContent>();

        // assert
        expect(brContents.length, 9);
      });
    });
  });
}
