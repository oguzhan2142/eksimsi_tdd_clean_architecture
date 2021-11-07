import '../../../../core/constants/fonts.dart';
import '../../../../core/utils/content_spans_generator.dart';
import '../../../../core/model/base_content.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SpoilerWidget extends StatefulWidget {
  final List<Content> contents;
  const SpoilerWidget({Key? key, required this.contents}) : super(key: key);

  @override
  _SpoilerWidgetState createState() => _SpoilerWidgetState();
}

class _SpoilerWidgetState extends State<SpoilerWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController expandController;
  late final Animation<double> animation;

  @override
  void initState() {
    expandController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    animation = CurvedAnimation(
      parent: expandController,
      curve: Curves.fastOutSlowIn,
    );
    super.initState();
  }

  void _runExpandCheck() {
    if (_isExpanded()) {
      expandController.forward();
    } else {
      expandController.reverse();
    }

    setState(() {});
  }

  bool _isExpanded() => animation.value == 0.0;

  List<InlineSpan> _extractSpoilerSpans() =>
      ContentSpansGenerator(contents: widget.contents).extract();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            _runExpandCheck();
          },
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '___ ',
                  style: GoogleFonts.getFont(
                    CONTENT_FONT_FAMILY,
                    color: Colors.green,
                  ),
                ),
                TextSpan(
                  text: 'spoiler ',
                  style: GoogleFonts.getFont(
                    CONTENT_FONT_FAMILY,
                    color: Colors.green,
                  ),
                ),
                WidgetSpan(
                  child: Icon(
                    _isExpanded() ? Icons.folder_open : Icons.folder,
                    size: 16,
                    color: Colors.green,
                  ),
                ),
                TextSpan(
                  text: ' ___',
                  style: GoogleFonts.getFont(
                    CONTENT_FONT_FAMILY,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        SizeTransition(
          axisAlignment: 1.0,
          sizeFactor: animation,
          child: Column(
            children: [
              RichText(
                text: TextSpan(
                  children: _extractSpoilerSpans(),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '___ ',
                      style: GoogleFonts.getFont(
                        CONTENT_FONT_FAMILY,
                        color: Colors.green,
                      ),
                    ),
                    TextSpan(
                      text: 'spoiler ',
                      style: GoogleFonts.getFont(
                        CONTENT_FONT_FAMILY,
                        color: Colors.green,
                      ),
                    ),
                    TextSpan(
                      text: ' ___',
                      style: GoogleFonts.getFont(
                        CONTENT_FONT_FAMILY,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
