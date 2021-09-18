import 'package:auto_size_text/auto_size_text.dart';
import 'package:eksimsi_tdd_clean_architecture/core/constants/fonts.dart';
import 'package:eksimsi_tdd_clean_architecture/features/agenda/domain/entities/entry.dart';
import 'package:eksimsi_tdd_clean_architecture/features/agenda/presentation/blocs/entry_page_bloc/entry_page_bloc.dart';
import 'package:eksimsi_tdd_clean_architecture/features/agenda/presentation/widgets/entry_list_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class EntriesScreen extends StatefulWidget {
  final String entryPageHref;

  const EntriesScreen({Key? key, required this.entryPageHref})
      : super(key: key);

  @override
  _EntriesScreenState createState() => _EntriesScreenState();
}

class _EntriesScreenState extends State<EntriesScreen> {
  late final entryPageBloc;

  @override
  void initState() {
    entryPageBloc = BlocProvider.of<EntryPageBloc>(context);

    entryPageBloc.add(GetEntryPageEvent(pageHref: widget.entryPageHref));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<EntryPageBloc, EntryPageState>(
          bloc: entryPageBloc,
          builder: (context, state) {
            if (state is GetEntryPageCompleted) {
              return FittedBox(
                fit: BoxFit.fitWidth,
                child: Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: AutoSizeText(
                    state.entriesPage.header,
                    maxFontSize: 14,
                    minFontSize: 12,
                    style: GoogleFonts.getFont(
                      HEADER_FONT_FAMILY,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              );
            }
            return Container();
          },
        ),
      ),
      body: BlocBuilder<EntryPageBloc, EntryPageState>(
        bloc: entryPageBloc,
        builder: (context, state) {
          if (state is GetEntryPageInProgress) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is GetEntryPageFailed) {
            return Center(child: Text(state.message));
          }

          if (state is GetEntryPageCompleted) {
            return RefreshIndicator(
              onRefresh: () async {
                entryPageBloc
                    .add(GetEntryPageEvent(pageHref: widget.entryPageHref));
              },
              child: ListView.separated(
                itemCount: state.entriesPage.entries.length,
                padding: EdgeInsets.only(top: 20, bottom: 90),
                separatorBuilder: (context, index) => SizedBox(height: 8),
                itemBuilder: (context, index) => EntryListItem(
                  entry: state.entriesPage.entries[index] as Entry,
                ),
              ),
            );
          }

          return Container();
        },
      ),
    );
  }
}
