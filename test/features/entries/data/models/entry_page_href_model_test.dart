

import 'package:eksimsi_tdd_clean_architecture/features/entries/data/models/entry_page_href_model.dart';
import 'package:eksimsi_tdd_clean_architecture/features/entries/domain/entities/entry_page_href.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([EntryPageHref])
void main() {
  const hrefWithNiceAndP =
      '/9-5-milyon-liraya-satilan-apartman-dairesi--7067078?a=nice&p=6';

  const hrefWithDailyniceAndP =
      '/9-5-milyon-liraya-satilan-apartman-dairesi--7067078?a=dailynice&p=6';

  const p = '6';
  const body = '/9-5-milyon-liraya-satilan-apartman-dairesi--7067078';

  

  test('should seperate parameters correctly', () {
    // arrange
    const isDailyNice = true;

    // act
    final model = EntryPageHrefModel(rawHref: hrefWithDailyniceAndP);

    // assert
    expect(model.body, body);
    expect(model.p, p);
    expect(model.isDailyNice, isDailyNice);
  });

  test('should return valid href when getHref executed', () {
    // arrange
    final model = EntryPageHrefModel(rawHref: '');
    model.body = body;
    model.p = p;
    model.hrefMode = EntryPageHrefMode.nice;
    // when(hrefModel.p).thenReturn(p);
    // when(hrefModel.body).thenReturn(body);
    // when(hrefModel.isNice).thenReturn(true);

    // act

    // assert
    expect(model.getHref(), hrefWithNiceAndP);
  });

  group('EntryPageHrefMode', () {
    const pageInfo = 'p=6';
    const populerInfo = 'a=popular';
    const niceInfo = 'a=nice';
    const dailyNiceInfo = 'a=dailynice';

    late EntryPageHref model;

    setUp(() {
      model = EntryPageHrefModel(rawHref: '');
      model.body = body;
      model.p = p;
    });

    test('should contains any type infos if its is type none', () {
      // arrange
      const expected = false;

      model.hrefMode = EntryPageHrefMode.none;

      // act
      final href = model.getHref();

      // assert
      expect(href.contains(dailyNiceInfo), expected);
      expect(href.contains(niceInfo), expected);
      expect(href.contains(populerInfo), expected);
    });

    test('should return correct href if it is populer', () {
      // arrange

      model.hrefMode = EntryPageHrefMode.popular;

      // act
      final href = model.getHref();
      final containsPage = href.contains(pageInfo);
      final containsPopuler = href.contains(populerInfo);

      // assert
      expect(containsPage, true);
      expect(containsPopuler, true);
    });

    test('should return correct href if it is nice', () {
      // arrange
      model.hrefMode = EntryPageHrefMode.nice;

      // act
      final href = model.getHref();
      final containsPage = href.contains(pageInfo);
      final containsNice = href.contains(niceInfo);

      // assert
      expect(containsPage, true);
      expect(containsNice, true);
    });

    test('should return correct href if it is dailyNice', () {
      model.hrefMode = EntryPageHrefMode.dailynice;

      // act
      final href = model.getHref();
      final containsPage = href.contains(pageInfo);
      final containsDailyNice = href.contains(dailyNiceInfo);

      // assert
      expect(containsPage, true);
      expect(containsDailyNice, true);
    });
  });

  group('turn', () {
    late EntryPageHref model;

    setUp(() {
      model = EntryPageHrefModel(rawHref: '');
      model.body = body;
      model.p = p;
    });

    test('toNice', () {
      // arrange
      model.hrefMode = EntryPageHrefMode.popular;

      // act
      model.toNice();

      // assert
      expect(model.hrefMode, EntryPageHrefMode.nice);
    });
    test('toDailyNice', () {
      // arrange
      model.hrefMode = EntryPageHrefMode.nice;

      // act
      model.toDailyNice();

      // assert
      expect(model.hrefMode, EntryPageHrefMode.dailynice);
    });
    test('toPopuler', () {
      // arrange
      model.hrefMode = EntryPageHrefMode.nice;

      // act
      model.toPopuler();

      // assert
      expect(model.hrefMode, EntryPageHrefMode.popular);
    });

    test('toNone', () {
      // arrange
      model.hrefMode = EntryPageHrefMode.dailynice;
      // act
      model.toNone();

      // assert
      expect(model.hrefMode, EntryPageHrefMode.none);
    });
  });
}
