import 'package:eksimsi_tdd_clean_architecture/core/parameters/parameter.dart';

class HrefParameter extends BaseParameter {
  final String href;

  HrefParameter({
    required this.href,
  });

  @override

  List<Object?> get props => [href];

  
}
