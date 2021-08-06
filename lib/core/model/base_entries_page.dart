import 'package:equatable/equatable.dart';

import 'base_entry.dart';
import 'show_all.dart';

abstract class BaseEntriesPage extends Equatable {
  final int page;
  final int totalPage;
  final String header;
  final String allHref;
  final String todayHref;
  final ShowAll? showAll;
  final List<BaseEntry> entries;

  BaseEntriesPage({
    required this.page,
    required this.totalPage,
    required this.header,
    required this.allHref,
    required this.todayHref,
    required this.showAll,
    required this.entries,
  });
}
