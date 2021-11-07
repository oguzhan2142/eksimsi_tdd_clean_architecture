import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/fonts.dart';
import '../../domain/entities/entries_page.dart';
import '../blocs/entry_page_bloc/entry_page_bloc.dart';
import 'pagination_numbers_widget.dart';

class PaginationWidget extends StatefulWidget {
  final EntriesPage entriesPage;

  const PaginationWidget({Key? key, required this.entriesPage})
      : super(key: key);

  @override
  State<PaginationWidget> createState() => _PaginationWidgetState();
}

class _PaginationWidgetState extends State<PaginationWidget> {
  late final EntryPageBloc entryPageBloc;

  @override
  void initState() {
    entryPageBloc = BlocProvider.of<EntryPageBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: MAIN_COLOR[700],
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              CupertinoIcons.arrow_left,
              color: SECONDARY_COLOR,
            ),
          ),
          TextButton(
            onPressed: () {
              final previousPageHref =
                  widget.entriesPage.entryPageHref.getPreviousPageHref();

              entryPageBloc.add(GetEntryPageEvent(pageHref: previousPageHref));
            },
            child: Text(
              'Önceki',
              style: GoogleFonts.getFont(
                HEADER_FONT_FAMILY,
                color: SECONDARY_COLOR,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: PaginationNumbersWidget(
              currentPage: widget.entriesPage.page!,
              maxPage: widget.entriesPage.totalPage!,
            ),
          ),
          TextButton(
            onPressed: () {
              final nextPageHref =
                  widget.entriesPage.entryPageHref.getNextPageHref();

              entryPageBloc.add(GetEntryPageEvent(pageHref: nextPageHref));
            },
            child: Text(
              'Sonraki',
              style: GoogleFonts.getFont(
                HEADER_FONT_FAMILY,
                color: SECONDARY_COLOR,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              final lastPageHref = widget.entriesPage.entryPageHref
                  .getLastPageHref(widget.entriesPage.totalPage!);

              entryPageBloc.add(GetEntryPageEvent(pageHref: lastPageHref));
            },
            icon: Icon(
              CupertinoIcons.arrow_right,
              color: SECONDARY_COLOR,
            ),
          )
        ],
      ),
    );
  }
}
