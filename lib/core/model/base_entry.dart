import 'package:eksimsi_tdd_clean_architecture/core/model/base_content.dart';
import 'package:equatable/equatable.dart';

abstract class BaseEntry extends Equatable {
  final String entryId;
  final String author;
  final int favouriteCount;
  final List<Content> contents;
  final String date;
  
  BaseEntry({
    required this.entryId,
    required this.author,
    required this.favouriteCount,
    required this.contents,
    required this.date,
  });



}
