import 'package:eksimsi_tdd_clean_architecture/core/error/exception.dart';
import 'package:eksimsi_tdd_clean_architecture/features/entries/data/models/entries_page_model.dart';
import 'package:eksimsi_tdd_clean_architecture/features/entries/data/models/entry_model.dart';

import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  EntriesPageModel _getModelFromFixture() {
    final document = fixtureAsDocument('entries_page.html');

    return EntriesPageModel.fromBody(body: document.body!, rawHref: '');
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

  test(
      'should throws ServerException when there isnt any item with entry-item-list id',
      () {
    // arrange
    final doc = fixtureAsDocument('entries_page_without_entry_model_ul.html');

    // act
    void call() => EntriesPageModel.fromBody(body: doc.body!, rawHref: '');

    // assert
    expect(call, throwsA(isA<ServerException>()));
  });
}
