import 'package:equatable/equatable.dart';

abstract class BaseEntry extends Equatable {
  final String entryId;
  final String author;
  final int favouriteCount;
  final String content;
  final String date;
  
  BaseEntry({
    required this.entryId,
    required this.author,
    required this.favouriteCount,
    required this.content,
    required this.date,
  });



}
