import 'package:eksimsi_tdd_clean_architecture/core/parameters/get_agenda_entry_page_parameter.dart';
import 'package:eksimsi_tdd_clean_architecture/core/parameters/parameter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late final GetAgendaEntriesPageParameter getAgendaEntriesPageParameter;

  setUp(() {
    getAgendaEntriesPageParameter =
        GetAgendaEntriesPageParameter(href: '', page: 1);
  });
  
  test('should be NoParameter subtype of [BaseParameter]', () {
    // assert
    expect(getAgendaEntriesPageParameter, isA<BaseParameter>());
  });
}
