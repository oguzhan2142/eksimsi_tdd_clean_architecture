import 'package:equatable/equatable.dart';

abstract class BaseHeader extends Equatable{
  final String title;
  final String href;

  BaseHeader({required this.title,required this.href});

}