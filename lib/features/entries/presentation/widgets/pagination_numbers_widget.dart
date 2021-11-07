import '../../../../core/constants/colors.dart';
import '../../../../core/constants/fonts.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PaginationNumbersWidget extends StatefulWidget {
  final int currentPage;
  final int maxPage;

  const PaginationNumbersWidget(
      {Key? key, required this.currentPage, required this.maxPage})
      : super(key: key);

  @override
  _PaginationNumbersWidgetState createState() =>
      _PaginationNumbersWidgetState();
}

class _PaginationNumbersWidgetState extends State<PaginationNumbersWidget> {
  final itemWidth = 30;

  String getText() {
    return '${widget.currentPage} / ${widget.maxPage}';
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () {},
        child: Text(
          getText(),
          style: GoogleFonts.getFont(
            HEADER_FONT_FAMILY,
            color: SECONDARY_COLOR,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
