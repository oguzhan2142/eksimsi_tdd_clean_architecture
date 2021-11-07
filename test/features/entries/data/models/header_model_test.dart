

import 'package:eksimsi_tdd_clean_architecture/features/entries/data/models/header_model.dart';
import 'package:eksimsi_tdd_clean_architecture/features/entries/domain/entities/header.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

main() {
  final agentaHeaderModel = HeaderModel(
    title: '4 ağustos 2021 a haber tayyip erdoğan canlı yayını',
    href:
        '/4-agustos-2021-a-haber-tayyip-erdogan-canli-yayini--6997176?a=popular',
    entryAmount: '424',
  );
  setUp(() {});

  test('should be subclass of AgentaHeader Entity', () {
    expect(agentaHeaderModel, isA<Header>());
  });

  test('should return valid model when passing </li> element', () {
    // arrange
    final document = fixtureAsDocument('agenda_header_fixture.html');
    final liTag = document.getElementsByTagName('li').first;

    // act
    final model = HeaderModel.fromLiTag(liTag);

    // assert
    expect(agentaHeaderModel, model);
  });

  test('should return valid json object', () {
    // arrange
    final expectedJson = {
      'title': '4 ağustos 2021 a haber tayyip erdoğan canlı yayını',
      'href':
          '/4-agustos-2021-a-haber-tayyip-erdogan-canli-yayini--6997176?a=popular',
      'entryAmount': '424',
    };

    // act
    final result = agentaHeaderModel.toJson();

    // assert
    expect(expectedJson, result);
  });
}
