import 'package:eksimsi_tdd_clean_architecture/core/extractors/content_spans_generator.dart';
import 'package:eksimsi_tdd_clean_architecture/core/model/base_content.dart';
import 'package:eksimsi_tdd_clean_architecture/features/agenda/domain/entities/contents.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  late List<Content> contents;
  late ContentSpansGenerator extractor;

  setUp(() {
    contents = [
      BrContent(),
      OuterLinkContent(href: 'href', text: 'text'),
      InnerLinkContent(href: 'href', text: 'text'),
      BrContent(),
      TextContent(text: 'text'),
      SpoilerContent(contents: [
        TextContent(text: 'text'),
        TextContent(text: 'text'),
        SpoilerContent(contents: [
          TextContent(text: 'text'),
          TextContent(text: 'text'),
        ]),
        TextContent(text: 'text'),
        TextContent(text: 'text'),
      ]),
    ];
    extractor = ContentSpansGenerator(contents: contents);
  });

  test('should return correct spans widget amount', () {
    // act
    final spans = extractor.extract();

    // assert
    expect(spans.length, 6);
  });


}
