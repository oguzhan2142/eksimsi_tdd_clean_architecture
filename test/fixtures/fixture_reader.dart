import 'dart:io';

import 'package:html/dom.dart';

Document fixtureAsDocument(String name) {
  final source = fixtureAsString(name);

  return Document.html(source);

}


String fixtureAsString(String name){
  return File('test/fixtures/$name').readAsStringSync();
}
