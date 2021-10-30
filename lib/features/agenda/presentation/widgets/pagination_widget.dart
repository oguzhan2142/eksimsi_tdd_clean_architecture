import 'package:eksimsi_tdd_clean_architecture/core/constants/colors.dart';
import 'package:eksimsi_tdd_clean_architecture/core/constants/fonts.dart';
import 'package:eksimsi_tdd_clean_architecture/features/agenda/domain/entities/entries_page.dart';
import 'package:eksimsi_tdd_clean_architecture/features/agenda/presentation/widgets/pagination_numbers_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PaginationWidget extends StatelessWidget {
  final EntriesPage entriesPage;

  const PaginationWidget({Key? key, required this.entriesPage})
      : super(key: key);

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
            icon: Icon(
              CupertinoIcons.arrow_left,
              color: SECONDARY_COLOR,
            ),
          ),
          TextButton(
            onPressed: () {},
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
              currentPage: entriesPage.page!,
              maxPage: entriesPage.totalPage!,
            ),
          ),
          TextButton(
            onPressed: () {

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
            onPressed: () {},
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
