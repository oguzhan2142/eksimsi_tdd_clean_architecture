import 'package:eksimsi_tdd_clean_architecture/core/constants/colors.dart';
import 'package:eksimsi_tdd_clean_architecture/core/constants/fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PaginationWidget extends StatelessWidget {
  final int currentPage;
  final int maxPage;

  const PaginationWidget(
      {Key? key, required this.currentPage, required this.maxPage})
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
          Expanded(child: Placeholder()),
          TextButton(
            onPressed: () {},
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
