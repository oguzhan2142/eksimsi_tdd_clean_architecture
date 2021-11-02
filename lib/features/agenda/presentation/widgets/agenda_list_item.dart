import '../../../../core/constants/colors.dart';
import '../../domain/entities/agenda_header.dart';
import '../pages/entries_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AgendaListItem extends StatelessWidget {
  final AgendaHeader agendaHeader;

  const AgendaListItem({
    Key? key,
    required this.agendaHeader,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EntriesScreen(
              entryPageHref: agendaHeader.href,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: MAIN_COLOR[700],
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.symmetric(horizontal: 16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      agendaHeader.title,
                      maxLines: 2,
                      style: GoogleFonts.montserrat(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: SECONDARY_COLOR,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                padding: EdgeInsets.all(8),
                width: 55,
                decoration: BoxDecoration(
                  color: SECONDARY_COLOR,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    agendaHeader.entryAmount,
                    style: GoogleFonts.montserrat(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: MAIN_COLOR[700],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
