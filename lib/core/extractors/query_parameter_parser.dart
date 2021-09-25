import 'package:eksimsi_tdd_clean_architecture/core/error/exception.dart';

class QueryParameterParser {
  late String _url;
  late final Map<String, String> parameters;

  QueryParameterParser({required String url}) {
    _url = url;

    _parse();
  }

  void _parse() {
    var uri = Uri.parse(_url);
    if (!uri.isAbsolute) {
      throw URIException();
    }

    parameters = uri.queryParameters;
  }
}