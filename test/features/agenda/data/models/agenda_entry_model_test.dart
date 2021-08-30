import 'package:eksimsi_tdd_clean_architecture/core/model/base_content.dart';
import 'package:eksimsi_tdd_clean_architecture/features/agenda/data/models/agenda_entry_model.dart';
import 'package:eksimsi_tdd_clean_architecture/features/agenda/domain/entities/agenda_entry.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:html/dom.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  late AgendaEntryModel model;
  setUp(() {
    Document document = fixture('agenda_model.html');
    Element liTag = document.getElementsByTagName('li').first;
    model = AgendaEntryModel.fromLiTag(liTag);
  });

  test('should subclass of AgendaEntry', () async {
    //Assert
    expect(model, isA<AgendaEntry>());
  });

  group('fromLi Method', () {
    test(
        'should return valid author, date, entryId, favouriteCount when use agenda_model.html',
        () {
      // arrange

      // assert
      expect(model.author, 'alperimmm');
      expect(model.date, '12.01.2017 16:40 ~ 16:42');
      expect(model.entryId, '65525976');
      expect(model.favouriteCount, 168);
    });

    test('should return list of contents when use agenda_model.html', () {
      // assert
      expect(model.contents, isNotEmpty);
    });

    test('should return 4 innerLinkContent when use agenda_model.html', () {
      // act
      final result =
          model.contents.where((element) => element is InnerLinkContent);

      // assert
      expect(result.length, 4);
    });

    test('should return 4 outerLinkContent when use agenda_model.html', () {
      // act
      final result =
          model.contents.where((element) => element is OuterLinkContent);

      // assert
      expect(result.length, 2);
    });

    test('should return only one spoiler content when use agenda_model.html',
        () {
      // act
      final result =
          model.contents.where((element) => element is SpoilerContent);

      // assert
      expect(result.length, 1);
    });
  });
}
