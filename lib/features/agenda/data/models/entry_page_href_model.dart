import '../../../../core/constants/remote_source_constants.dart';
import '../../../../core/extractors/query_parameter_parser.dart';
import '../../domain/entities/entry_page_href.dart';

class EntryPageHrefModel extends EntryPageHref {


  EntryPageHrefModel({
    required String rawHref,
  }) {
    _extractRawHref(rawHref);
  }
  void _extractRawHref(String rawHref) {
    final url = EKSI_BASE_DOMAIN + rawHref;
    final parser = QueryParameterParser(url: url);

    final page = parser.parameters[PAGE_KEY];

    if (page == null) {
      this.p = '1';
    } else {
      this.p = page;
    }

    final mode = parser.parameters[MODE_KEY];

    switch (mode) {
      case NICE_VALUE:
        this.hrefMode = EntryPageHrefMode.nice;
        break;
      case DAILYNICE_VALUE:
        this.hrefMode = EntryPageHrefMode.dailynice;
        break;
      case POPULER_VALUE:
        this.hrefMode = EntryPageHrefMode.popular;
        break;
      default:
        this.hrefMode = EntryPageHrefMode.none;
    }

    final body = parser.path;
    this.body = body;
  }

}
