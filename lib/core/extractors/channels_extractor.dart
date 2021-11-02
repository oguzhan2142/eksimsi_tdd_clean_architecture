import 'package:eksimsi_tdd_clean_architecture/core/error/exception.dart';
import 'package:eksimsi_tdd_clean_architecture/core/extractors/base_extractor.dart';
import 'package:html/dom.dart';

class ChannelsExtractor extends Extractor<List<Element>> {
  ChannelsExtractor({required Element body}) : super(body);

  @override
  List<Element> extract() {
    final list = body.querySelector('#channel-follow-list');

    if (list == null) {
      throw ExtractorException();
    }

    return list.getElementsByTagName('li');
  }
}
