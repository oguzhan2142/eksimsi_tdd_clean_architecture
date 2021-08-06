import 'package:equatable/equatable.dart';

class ShowAll extends Equatable {
  final String text;
  final String href;

  ShowAll({
    required this.text,
    required this.href,
  });

  @override
  List<Object?> get props => [text, href];
}
