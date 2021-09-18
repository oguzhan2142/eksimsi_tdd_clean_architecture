import 'package:eksimsi_tdd_clean_architecture/core/error/exception.dart';
import 'package:eksimsi_tdd_clean_architecture/core/extractors/query_parameter_parser.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  final linkWithOneParameter = 'https://eksisozluk.com/motor--33355?p=2';
  final linkWithTwoParameter =
      'https://eksisozluk.com/turk-genclerinin-turkiyeden-nefret-etmesi--7035360?a=popular&p=2';
  final linkWithZeroParameter = 'https://eksisozluk.com/motor--33355';
  final invalidLink = 'motor--33355';

  test('should throws [UriException] if url is not valid ', () {
    // assert
    expect(
      () => QueryParameterParser(url: invalidLink),
      throwsA(isA<URIException>()),
    );
  });

  test(
      'should return zero query parameter if links contains no query parameter',
      () {
    // arrange
    final parser = QueryParameterParser(url: linkWithZeroParameter);

    // act
    final length = parser.parameters.length;

    // assert
    expect(length, 0);
  });

  test(
      'should return one query parameter if links contains one query parameter',
      () {
    // arrange
    final parser = QueryParameterParser(url: linkWithOneParameter);

    // act
    final length = parser.parameters.length;

    // assert
    expect(length, 1);
  });

  test('should return valid parameter', () {
    // arrange
    final parser = QueryParameterParser(url: linkWithOneParameter);

    // act
    final parameters = parser.parameters;

    // assert
    expect(parameters['p'], '2');
  });
  test(
      'should return two query parameter if links contains two query parameter',
      () {
    // arrange
    final parser = QueryParameterParser(url: linkWithTwoParameter);

    // act
    final length = parser.parameters.length;

    // assert
    expect(length, 2);
  });
}
