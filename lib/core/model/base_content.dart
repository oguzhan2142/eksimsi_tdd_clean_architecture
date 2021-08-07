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

class InnerLinkContent extends LinkContent {
  InnerLinkContent({
    required String href,
    required String text,
  }) : super(
          href: href,
          text: text,
        );
}

class OuterLinkContent extends LinkContent {
  OuterLinkContent({
    required String href,
    required String text,
  }) : super(
          href: href,
          text: text,
        );
}

class SpoilerContent extends Content {
  final List<Content> contents;

  SpoilerContent({required this.contents});

  @override
  List<Object?> get props => [contents];
}

class BrContent extends Content {
  @override
  List<Object?> get props => [];
}

class TextContent extends Content {
  final String text;

  TextContent({
    required this.text,
  });

  @override
  List<Object?> get props => [text];
}
