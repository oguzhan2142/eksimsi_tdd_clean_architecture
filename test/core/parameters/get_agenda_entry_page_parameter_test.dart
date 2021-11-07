import 'package:eksimsi_tdd_clean_architecture/core/parameters/href_page_parameter.dart';
import 'package:eksimsi_tdd_clean_architecture/core/parameters/parameter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late final HrefPageParameter getAgendaEntriesPageParameter;

  setUp(() {
    getAgendaEntriesPageParameter =
        HrefPageParameter(href: '', page: 1);
  });
  
  test('should be NoParameter subtype of [BaseParameter]', () {
    // assert
    expect(getAgendaEntriesPageParameter, isA<BaseParameter>());
  });
}
