import 'package:eksimsi_tdd_clean_architecture/core/model/base_content.dart';
import 'package:eksimsi_tdd_clean_architecture/features/agenda/domain/entities/contents.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(() {});

  group('Content type check', () {
    test('should InnerLink is a Content', () {
      // arrange
      final innerLink = InnerLinkContent(href: 'href', text: 'text');

      // assert
      expect(innerLink, isA<Content>());
    });
    test('should OuterLink is a Content', () {
      // arrange
      final outerLink = OuterLinkContent(href: 'href', text: 'text');

      // assert
      expect(outerLink, isA<Content>());
    });
    test('should TextContent is a Content', () {
      // arrange
      final text = TextContent(text: 'text');

      // assert
      expect(text, isA<Content>());
    });

    test('should Br is a Content', () {
      // arrange
      final br = BrContent();

      // assert
      expect(br, isA<Content>());
    });

    test('should Spoiler is a Content', () {
      // arrange
      final spoiler = SpoilerContent(contents: []);

      // assert
      expect(spoiler, isA<Content>());
    });
  });
}
