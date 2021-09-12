import 'package:eksimsi_tdd_clean_architecture/core/error/exception.dart';
import 'package:eksimsi_tdd_clean_architecture/core/extractors/entry_page_extractor.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:html/dom.dart';

import '../../fixtures/fixture_reader.dart';

main() {
  EntryPageExtractor _createExtractorWithAFixture(String fixture) {
    Document doc = fixtureAsDocument(fixture);
    return EntryPageExtractor(body: doc.body!);
  }

  group('extractShowAll', () {
    test('should return null if there is no a tag class name with showall', () {
      // arrange
      final extractor =
          _createExtractorWithAFixture('entry_page_without_show_all_btn.html');
      // act
      final showAll = extractor.extractShowAll();

      // assert
      expect(showAll, isNull);
    });

    test('should return null if show all button contains empty href string', () {
      // arrange
      final extractor =
          _createExtractorWithAFixture('entry_page_with_empty_href_show_all_btn.html');
      // act
      final showAll = extractor.extractShowAll();

      // assert
      expect(showAll, isNull);
    });

    test('should return null if show all a Tag has no href atribute', () {
      // arrange
      final extractor = _createExtractorWithAFixture(
          'entry_page_with_no_href_attribute_show_all_btn.html');
      // act
      final showAll = extractor.extractShowAll();

      // assert
      expect(showAll, isNull);
    });
    test('should return valid showAll', () {
      // arrange
      final actualHref =
          '/para-verilip-ustune-bir-de-dert-sahibi-eden-seyler--4762745?focusto=127930246';
      final actualLabel = '1266 entry daha';

      final extractor =
          _createExtractorWithAFixture('entry_page_with_show_all_btn.html');
      // act
      final showAll = extractor.extractShowAll()!;

      // assert
      expect(actualHref, showAll.href);
      expect(actualLabel, showAll.text);
    });
  });

  group('extractAllHref and extractTodayHref', () {
    void _expectThrowsAServerException(EntryPageExtractor entryPageExtractor) {
      expect(() => entryPageExtractor.extractTodayHref(),
          throwsA(isA<ServerException>()));
      expect(() => entryPageExtractor.extractAllHref(),
          throwsA(isA<ServerException>()));
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
