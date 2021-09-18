import 'package:eksimsi_tdd_clean_architecture/core/extractors/content_spans_generator.dart';
import 'package:eksimsi_tdd_clean_architecture/features/agenda/domain/entities/entry.dart';
import 'package:flutter/material.dart';

class EntryListItem extends StatelessWidget {
  final Entry entry;

  final textSize = 14.0;

  const EntryListItem({Key? key, required this.entry}) : super(key: key);

  List<InlineSpan> getSpans() =>
      ContentSpansGenerator(contents: entry.contents).extract();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
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
      ),
    );
  }
}
