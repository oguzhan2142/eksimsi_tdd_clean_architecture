import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../features/entries/domain/entities/contents.dart';
import '../../features/entries/presentation/widgets/spoiler_widget.dart';
import '../constants/colors.dart';
import '../constants/fonts.dart';
import '../model/base_content.dart';

class ContentSpansGenerator {
  List<Content> contents;
  final _textSize = 14.0;

  ContentSpansGenerator({
    required this.contents,
  });

  List<InlineSpan> extract() {
    final spans = <InlineSpan>[];

    for (final item in contents) {
      if (item is TextContent) {
        spans.add(
          TextSpan(
            text: item.text,
            style: GoogleFonts.getFont(
              CONTENT_FONT_FAMILY,
              color: TEXT_COLOR,
              fontSize: _textSize,
            ),
          ),
        );
      }
      if (item is OuterLinkContent) {
        spans.add(
          WidgetSpan(
            child: GestureDetector(
              child: Text(
                item.text,
                style: GoogleFonts.getFont(
                  CONTENT_FONT_FAMILY,
                  fontSize: _textSize,
                  color: Colors.yellow,
                ),
              ),
            ),
          ),
        );
      }

      if (item is InnerLinkContent) {
        spans.add(
          WidgetSpan(
            child: GestureDetector(
              child: Text(
                item.text,
                style: GoogleFonts.getFont(
                  CONTENT_FONT_FAMILY,
                  fontSize: _textSize,
                  color: Colors.green,
                ),
              ),
            ),
          ),
        );
      }

      if (item is BrContent) {
        spans.add(const TextSpan(text: '\n'));
      }

      if (item is SpoilerContent) {
        spans.add(WidgetSpan(child: SpoilerWidget(contents: item.contents)));
      }
    }
    return spans;
  }
}
