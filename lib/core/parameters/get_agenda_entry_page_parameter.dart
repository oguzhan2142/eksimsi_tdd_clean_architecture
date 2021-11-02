import 'package:eksimsi_tdd_clean_architecture/core/parameters/parameter.dart';

class GetAgendaEntriesPageParameter extends BaseParameter {
  final String href;
  final int? page;

  GetAgendaEntriesPageParameter({
    required this.href,
    this.page,
  });
}
