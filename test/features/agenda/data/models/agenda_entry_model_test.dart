import 'package:eksimsi_tdd_clean_architecture/features/agenda/data/models/agenda_content_model.dart';
import 'package:eksimsi_tdd_clean_architecture/features/agenda/data/models/agenda_entry_model.dart';
import 'package:eksimsi_tdd_clean_architecture/features/agenda/domain/entities/agenda_entry.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final agendaEntryModel = AgendaEntryModel(
    author: 'alperimmm',
    agendaContents: [],
    date: 'date',
    entryId: '65525976',
    favouriteCount: 168,
  );

  setUp(() {});

  test('should subclass of AgendaEntry', () async {
    //Assert
    expect(agendaEntryModel, isA<AgendaEntry>());
  });

  test('should return valid model when passing </li> element to fromLi method',
      () {
    // arrange
    final document = fixture('agenda_model.html');
    final liTag = document.getElementsByTagName('li').first;
    // act
    final result = AgendaEntryModel.fromLiTag(liTag);

    // assert
    expect(agendaEntryModel, result);
  });
}
