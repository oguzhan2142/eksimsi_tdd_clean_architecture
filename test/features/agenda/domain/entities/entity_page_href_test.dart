import 'package:eksimsi_tdd_clean_architecture/features/agenda/data/models/entry_page_href_model.dart';
import 'package:eksimsi_tdd_clean_architecture/features/agenda/domain/entities/entry_page_href.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  final hrefWithNiceAndP =
      '/9-5-milyon-liraya-satilan-apartman-dairesi--7067078?a=nice&p=6';

  final hrefWithDailyniceAndP =
      '/9-5-milyon-liraya-satilan-apartman-dairesi--7067078?a=dailynice&p=6';
  final hrefWithpopularAndP =
      '/9-5-milyon-liraya-satilan-apartman-dairesi--7067078?a=popular&p=6';
  final hrefWithPopuler =
      '/tanrinin-varligi-kanitlanabilir-mi-sorunsali--7070566?a=popular';


  group('getPreviousPage', () {
    test('should return correct page when its nice and p', () {
      // arrange
      final expected =
          '/9-5-milyon-liraya-satilan-apartman-dairesi--7067078?a=nice&p=5';
      EntryPageHref model = EntryPageHrefModel(rawHref: hrefWithNiceAndP);

      // act
      final href = model.getPreviousPageHref();

      // assert
      expect(href, expected);
    });

    test('should return correct page when its dailynice and p', () {
      // arrange
      final expected =
          '/9-5-milyon-liraya-satilan-apartman-dairesi--7067078?a=dailynice&p=5';
      EntryPageHref model =
          EntryPageHrefModel(rawHref: hrefWithDailyniceAndP);

      // act
      final href = model.getPreviousPageHref();

      // assert
      expect(href, expected);
    });

    test('should return correct page when its popular and p', () {
      // arrange
      final expected =
          '/9-5-milyon-liraya-satilan-apartman-dairesi--7067078?a=popular&p=5';
      EntryPageHref model =
          EntryPageHrefModel(rawHref: hrefWithpopularAndP);

      // act
      final href = model.getPreviousPageHref();

      // assert
      expect(href, expected);
    });
    test('should return correct page when its only popular', () {
      final expected =
          '/tanrinin-varligi-kanitlanabilir-mi-sorunsali--7070566?a=popular&p=1';
      EntryPageHref model = EntryPageHrefModel(rawHref: hrefWithPopuler);

      // act
      final href = model.getPreviousPageHref();

      // assert
      expect(href, expected);
      // assert
    });
  });
  group('getNextPage', () {
    test('should return correct page when its nice and p', () {
      // arrange
      final expected =
          '/9-5-milyon-liraya-satilan-apartman-dairesi--7067078?a=nice&p=7';
      EntryPageHref model = EntryPageHrefModel(rawHref: hrefWithNiceAndP);

      // act
      final href = model.getNextPageHref();

      // assert
      expect(href, expected);
    });

    test('should return correct page when its dailynice and p', () {
      // arrange
      final expected =
          '/9-5-milyon-liraya-satilan-apartman-dairesi--7067078?a=dailynice&p=7';
      EntryPageHref model =
          EntryPageHrefModel(rawHref: hrefWithDailyniceAndP);

      // act
      final href = model.getNextPageHref();

      // assert
      expect(href, expected);
    });

    test('should return correct page when its popular and p', () {
      // arrange
      final expected =
          '/9-5-milyon-liraya-satilan-apartman-dairesi--7067078?a=popular&p=7';
      EntryPageHref model =
          EntryPageHrefModel(rawHref: hrefWithpopularAndP);

      // act
      final href = model.getNextPageHref();

      // assert
      expect(href, expected);
    });
    test('should return correct page when its only popular', () {
      final expected =
          '/tanrinin-varligi-kanitlanabilir-mi-sorunsali--7070566?a=popular&p=2';
      EntryPageHref model = EntryPageHrefModel(rawHref: hrefWithPopuler);

      // act
      final href = model.getNextPageHref();

      // assert
      expect(href, expected);
      // assert
    });
  });
}
