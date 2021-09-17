import 'package:flutter/material.dart';

class AgendaTab extends StatelessWidget {
  const AgendaTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 4,
      itemBuilder: (context, index) => Placeholder(),
    );
  }
}
