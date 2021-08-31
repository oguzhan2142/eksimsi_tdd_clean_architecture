import 'package:equatable/equatable.dart';


abstract class Content extends Equatable {}

abstract class LinkContent extends Content {
  final String href;
  final String text;

  LinkContent({
    required this.href,
    required this.text,
  });

  @override
  List<Object?> get props => [href, text];
}

