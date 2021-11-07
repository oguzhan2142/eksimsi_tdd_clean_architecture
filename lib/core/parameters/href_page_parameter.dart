import 'package:eksimsi_tdd_clean_architecture/core/parameters/parameter.dart';

class HrefPageParameter extends BaseParameter {
  final String href;
  final int? page;

  HrefPageParameter({
    required this.href,
    this.page,
  });

  @override

  List<Object?> get props => [href, page];
}
