import 'package:eksimsi_tdd_clean_architecture/features/agenda/domain/entities/agenda_header.dart';
import 'package:eksimsi_tdd_clean_architecture/features/agenda/presentation/widgets/agenda_list_item.dart';
import 'package:flutter/material.dart';

class AgendaTab extends StatelessWidget {
  const AgendaTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 4,
      padding: EdgeInsets.only(top: 20),
      separatorBuilder: (context, index) => SizedBox(height: 8),
      itemBuilder: (context, index) => AgendaListItem(
        agendaHeader: AgendaHeader(title: 'title', href: '', entryAmount: '1'),
      ),
    );
  }
}
