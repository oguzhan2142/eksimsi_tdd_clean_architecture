import 'package:equatable/equatable.dart';

class ChannelHeader extends Equatable {
  final String title;
  final String subTitle;
  final String href;

  const ChannelHeader({
    required this.title,
    required this.subTitle,
    required this.href,
  });

  @override
  List<Object?> get props => [title, subTitle, href];
}
