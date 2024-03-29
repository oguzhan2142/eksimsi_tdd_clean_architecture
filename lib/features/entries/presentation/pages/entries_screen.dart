import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/fonts.dart';
import '../../domain/entities/entry.dart';
import '../blocs/entry_page_bloc/entry_page_bloc.dart';
import '../widgets/entry_list_item.dart';
import '../widgets/pagination_widget.dart';

class EntriesScreen extends StatefulWidget {
  final String entryPageHref;

  const EntriesScreen({Key? key, required this.entryPageHref})
      : super(key: key);

  @override
  _EntriesScreenState createState() => _EntriesScreenState();
}

class _EntriesScreenState extends State<EntriesScreen> {
  late final EntryPageBloc entryPageBloc;

  @override
  void initState() {
    entryPageBloc = BlocProvider.of<EntryPageBloc>(context);

    entryPageBloc.add(
      GetEntryPageEvent(
        pageHref: widget.entryPageHref,
      ),
    );
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
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is GetEntryPageFailed) {
            return Center(child: Text(state.message));
          }

          if (state is GetEntryPageCompleted) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: RefreshIndicator(
                onRefresh: () async {
                  entryPageBloc
                      .add(GetEntryPageEvent(pageHref: widget.entryPageHref));
                },
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.entriesPage.entries.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 5),
                        itemBuilder: (context, index) => EntryListItem(
                          entry: state.entriesPage.entries[index] as Entry,
                        ),
                      ),
                      const SizedBox(height: 20),
                      if (state.entriesPage.page == null ||
                          state.entriesPage.totalPage == null)
                        const SizedBox()
                      else
                        PaginationWidget(
                          entriesPage: state.entriesPage,
                        ),
                      const SizedBox(height: 30),
                    ],
                  ),
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
