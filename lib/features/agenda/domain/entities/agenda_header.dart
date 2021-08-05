import 'package:equatable/equatable.dart';

class AgendaHeader extends Equatable {
  final String title;
  final String href;
  final String entryAmount;
  
  AgendaHeader({
    required this.title,
    required this.href,
    required this.entryAmount,
  }) : super();

  @override
  List<Object?> get props => [title, href, entryAmount];
}
