import 'dart:io';

import 'package:html/dom.dart';

Document fixture(String name) {
  final file = File('test/fixtures/$name').readAsStringSync();

  return Document.html(file);

}
