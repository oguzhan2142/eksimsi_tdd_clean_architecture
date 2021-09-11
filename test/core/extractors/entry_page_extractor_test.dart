
import 'package:eksimsi_tdd_clean_architecture/core/error/exception.dart';
import 'package:eksimsi_tdd_clean_architecture/core/extractors/entry_page_extractor.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:html/dom.dart';

import '../../fixtures/fixture_reader.dart';

main() {
  group('extractAllHref and extractTodayHref', () {
    void _expectThrowsAServerException(EntryPageExtractor entryPageExtractor) {
      expect(() => entryPageExtractor.extractTodayHref(),
          throwsA(isA<ServerException>()));
      expect(() => entryPageExtractor.extractAllHref(),
          throwsA(isA<ServerException>()));
    }

    EntryPageExtractor _createExtractorWithAFixture(String fixture) {
      Document doc = fixtureAsDocument(fixture);
      return EntryPageExtractor(body: doc.body!);
    }

    test('should throw ServerException when element href equals to null', () {
      // arrange
      final extractor =
          _createExtractorWithAFixture('entries_page_without_nice_hrefs.html');

      // assert
      _expectThrowsAServerException(extractor);
    });

    test(
        'should return ServerException when there isnt any today or all button',
        () {
      // arrange
      final extractor =
          _createExtractorWithAFixture('entries_page_without_nice_div.html');

      // assert
      _expectThrowsAServerException(extractor);
    });
  });

  group('extractEntries', () {
    test(
        'should throws ServerException when couldnt find any entry list ul inside body',
        () {
      // arrange
      final body =
          fixtureAsDocument('entries_page_without_entry_model_ul.html').body;

      // act
      EntryPageExtractor pageExtractor = EntryPageExtractor(body: body!);

      // assert
      expect(() => pageExtractor.extractEntries(),
          throwsA(isA<ServerException>()));
    });

    test('should return valid EntryModel list', () {
      // arrange
      final firstsAuthor = 'cift l li entellektuel';
      final secondsDate = '01.09.2021 10:07';
      final lastFavouriteCount = 13;

      Document doc = fixtureAsDocument('entries_page.html');
      EntryPageExtractor extractor = new EntryPageExtractor(body: doc.body!);

      // act
      final list = extractor.extractEntries();

      // assert
      expect(list.first.author, firstsAuthor);
      expect(list[1].date, secondsDate);
      expect(list.last.favouriteCount, lastFavouriteCount);
    });
  });
}
