import 'package:eksimsi_tdd_clean_architecture/core/model/base_content.dart';
import 'package:eksimsi_tdd_clean_architecture/core/model/content_extractor.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:html/dom.dart';
import 'package:mockito/annotations.dart';

import '../../fixtures/fixture_reader.dart';

@GenerateMocks([NodeList, Node])
void main() {
  late ContentExtractor extractor;
  late NodeList nodeListOnlyContainsSpoilerContent;

  setUp(() {
    extractor = ContentExtractor();
    final document = fixture('spoiler_content.html');

    nodeListOnlyContainsSpoilerContent =
        document.getElementsByTagName('body').first.nodes;
  });

  group('for spoiler content', () {
    group('when use spoiler_content.html file', () {
      test('should return only one spoiler content', () {
        // act
        extractor.extract(nodeListOnlyContainsSpoilerContent);
        final lenght = extractor.contents.length;
        // assert
        expect(lenght, 1);
      });

      test(
          'should return spoiler content with nodelist which hasn\'t any inner_link_content',
          () {
        // act
        extractor.extract(nodeListOnlyContainsSpoilerContent);
        final content = extractor.contents.first as SpoilerContent;
        final nodes = content.contents;

        final innerLinks =
            nodes.where((element) => element is InnerLinkContent);
        // assert
        expect(innerLinks.length, 0);
      });

      test('should return spoiler content with nodelist which has 9 br content',
          () {
        // act
        extractor.extract(nodeListOnlyContainsSpoilerContent);
        final content = extractor.contents.first as SpoilerContent;

        final brContents =
            content.contents.where((element) => element is BrContent);

        // assert
        expect(brContents.length, 9);
      });
    });
  });
}
