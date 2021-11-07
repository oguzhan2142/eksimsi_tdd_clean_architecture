
import 'package:eksimsi_tdd_clean_architecture/features/entries/data/extractors/channels_extractor.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:html/dom.dart';


import '../../../../fixtures/fixture_reader.dart';

void main() {
  Element body;

  late ChannelsExtractor extractor;
  final Document doc = fixtureAsDocument('channels.html');

  setUp(() {
    body = doc.body!;
    extractor = ChannelsExtractor(body: body);
  });

  test('return type should be [List<Element>]', () {
    // act
    final elements = extractor.extract();
    // assert
    expect(elements, isA<List<Element>>());
  });

 
  test('should return correct list of Elements', () {
    // arrange
    const firstExpected = '''
    <li>
    <button type="button" class="channel-button" data-follow-url="" data-unfollow-url="" data-followed="false">takip et</button>
    <h3><a class="index-link" href="/basliklar/kanal/haber" title="yurtta ve dünyada olan biten">#haber</a></h3>

    <p>yurtta ve dünyada olan biten</p>
  </li>
    ''';

    const lastExpected = '''
    <li>
    <button type="button" class="channel-button" data-follow-url="" data-unfollow-url="" data-followed="false">takip et</button>
    <h3><a class="index-link" href="/basliklar/kanal/troll" title="troll içerik">#troll</a></h3>

    <p>troll içerik</p>
  </li>
    ''';

    // act
    final elements = extractor.extract();
    final firstElementHtml = elements.first.outerHtml;
    final lastElementsHtml = elements.last.outerHtml;

    // assert
    expect(firstElementHtml.trim(), firstExpected.trim());
    expect(lastElementsHtml.trim(), lastExpected.trim());
  });
}
