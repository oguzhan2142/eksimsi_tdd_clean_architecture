import 'package:eksimsi_tdd_clean_architecture/core/error/exception.dart';
import 'package:eksimsi_tdd_clean_architecture/features/agenda/data/models/entries_page_model.dart';
import 'package:eksimsi_tdd_clean_architecture/features/agenda/data/models/entry_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:html/dom.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'entries_page_model_test.mocks.dart';


main() {
  AgendaEntriesPageModel _getModelFromFixture() {
    final document = fixtureAsDocument('entries_page.html');

    return AgendaEntriesPageModel.fromBody(document.body!);
  }

  test('should return valid EntriesPageModel when call fromBody method', () {
    final model = _getModelFromFixture();
    // assert
    expect(model, isNotNull);
  });

  test('should return list of EntryModel when call fromBody method', () {
    final model = _getModelFromFixture();

    // assert
    expect(model.entries, isNotEmpty);
    expect(model.entries.first, isA<EntryModel>());
  });

  test('should throws ServerException when page greater than totalPage', () {
    // arrange

    final modelWithBadPageCounts =
        fixtureAsDocument('entries_page_with_wrong_page.html');
    final body = modelWithBadPageCounts.body!;

    // assert
    expect(() => AgendaEntriesPageModel.fromBody(body),
        throwsA(isA<ServerException>()));
  });

  test(
      'should throws ServerException when there isnt any item with entry-item-list id',
      () {
    // arrange
    final document = MockDocument();
    final body = MockElement();

    when(document.body).thenReturn(body);

    when(body.getElementsByTagName('li')).thenReturn(<Element>[]);

    // act

    // assert
    expect(AgendaEntriesPageModel.fromBody(document.body!),
        throwsA(isA<ServerException>()));
  });
}