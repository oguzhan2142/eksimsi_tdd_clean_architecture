import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/utils/content_spans_generator.dart';
import '../../domain/entities/entry.dart';

const textSize = 14.0;

class EntryListItem extends StatelessWidget {
  final Entry entry;

  const EntryListItem({Key? key, required this.entry}) : super(key: key);

  List<InlineSpan> getSpans() =>
      ContentSpansGenerator(contents: entry.contents).extract();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: MAIN_COLOR[700],
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              children: getSpans(),
            ),
          ),
        ],
      ),
    );
  }
}
