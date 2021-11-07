import 'package:eksimsi_tdd_clean_architecture/core/error/exception.dart';
import 'package:eksimsi_tdd_clean_architecture/features/entries/data/extractors/entry_page_extractor.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:html/dom.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  EntryPageExtractor _createExtractorWithAFixture(String fixture) {
    final Document doc = fixtureAsDocument(fixture);
    return EntryPageExtractor(body: doc.body!);
  }

  group('sukela buttons', () {
    late EntryPageExtractor extractorWithCorrectData;

    setUp(() {
      extractorWithCorrectData =
          _createExtractorWithAFixture('entries_page.html');
    });

    group('extractHref method', () {
      test('extractAllHref should return valid href', () {
        const actual =
            '/turkiyenin-2021-ikinci-ceyrekte-21-7-buyumesi--7022174?a=nice';

        final allHref = extractorWithCorrectData.extractAllHref();

        expect(actual, allHref);
      });

      test('extractTodayHref should return valid href', () {
        const actual =
            '/turkiyenin-2021-ikinci-ceyrekte-21-7-buyumesi--7022174?a=dailynice';

        final todayHref = extractorWithCorrectData.extractTodayHref();

        expect(actual, todayHref);
      });

      test("should return [ServerException] when can't find href", () {
        final extractor =
            _createExtractorWithAFixture('entries_page_without_page_href.html');

        expect(() => extractor.extractHref(), throwsA(isA<ServerException>()));
      });

      test('should return valid href when data appropriate', () {
        const actualHref =
            "/turkiyenin-2021-ikinci-ceyrekte-21-7-buyumesi--7022174";

        final href = extractorWithCorrectData.extractHref();

        expect(actualHref, href);
      });
    });
  });

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

    test('should return null if show all button contains empty href string',
        () {
      // arrange
      final extractor = _createExtractorWithAFixture(
          'entry_page_with_empty_href_show_all_btn.html');
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

  test('should return true entiries count', () {
    // arrange
    final count = 10;
    Document doc = fixtureAsDocument('entries_page.html');
    EntryPageExtractor extractor = new EntryPageExtractor(body: doc.body!);
    // act
    final entries = extractor.extractEntries();
    // assert
    expect(count, entries.length);
  });
}
