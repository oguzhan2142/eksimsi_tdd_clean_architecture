import 'package:html/dom.dart';

/// Base class for extractors
/// Extractors using for parsing [html] page
abstract class Extractor<T> {
  final Element body;

  
  Extractor(
     this.body,
  );

  T extract();
}
