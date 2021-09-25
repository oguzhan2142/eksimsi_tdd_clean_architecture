import 'package:eksimsi_tdd_clean_architecture/features/agenda/presentation/blocs/headers_bloc/headers_bloc.dart';
import 'package:eksimsi_tdd_clean_architecture/features/agenda/presentation/widgets/agenda_list_item.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class AgendaTab extends StatefulWidget {
  const AgendaTab({Key? key}) : super(key: key);

  @override
  State<AgendaTab> createState() => _AgendaTabState();
}

class _AgendaTabState extends State<AgendaTab> {
  late final HeadersBloc headersBloc;

  @override
  void initState() {
    headersBloc = BlocProvider.of<HeadersBloc>(context);

    headersBloc.add(GetAgendaHeadersEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HeadersBloc, HeadersState>(
      bloc: headersBloc,
      builder: (context, state) {
        if (state is GetAgendaHeadersFailed) {
          return Text(state.message);
        }

        if (state is GetAgendaHeadersInProgress) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is GetAgendaHeadersCompleted) {
          return RefreshIndicator(
            onRefresh: () async {
              headersBloc.add(GetAgendaHeadersEvent());
            },
            child: ListView.separated(
              itemCount: state.headers.length,
              padding: EdgeInsets.only(top: 20, bottom: 90),
              separatorBuilder: (context, index) => SizedBox(height: 8),
              itemBuilder: (context, index) => AgendaListItem(
                agendaHeader: state.headers[index],
              ),
            ),
          );
        }

        return SizedBox();
      },
    );
  }
}