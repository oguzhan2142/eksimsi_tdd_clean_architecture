enum EntryPageHrefMode { none, popular, nice, dailynice }

const PAGE_KEY = 'p';
const NICE_VALUE = 'nice';
const DAILYNICE_VALUE = 'dailynice';
const POPULER_VALUE = 'popular';
const MODE_KEY = 'a';

class EntryPageHref {
  late String body;
  late String p;
  late EntryPageHrefMode hrefMode;

  bool get isDailyNice => hrefMode == EntryPageHrefMode.dailynice;
  bool get isNice => hrefMode == EntryPageHrefMode.nice;
  bool get isPopuler => hrefMode == EntryPageHrefMode.popular;

  String getHref() {
    var parameters = <String, String>{};
    if (isPopuler) {
      parameters[MODE_KEY] = POPULER_VALUE;
    } else if (isNice) {
      parameters[MODE_KEY] = NICE_VALUE;
    } else if (isDailyNice) {
      parameters[MODE_KEY] = DAILYNICE_VALUE;
    }

    parameters[PAGE_KEY] = p;

    final uri = Uri(path: body, queryParameters: parameters);
    return uri.toString();
  }

  void toNice() {
    hrefMode = EntryPageHrefMode.nice;
  }

  void toDailyNice() {
    hrefMode = EntryPageHrefMode.dailynice;
  }

  void toPopuler() {
    hrefMode = EntryPageHrefMode.popular;
  }

  void toNone() {
    hrefMode = EntryPageHrefMode.none;
  }

  String getNextPageHref() {
    var parameters = <String, String>{};
    if (isPopuler) {
      parameters[MODE_KEY] = POPULER_VALUE;
    } else if (isNice) {
      parameters[MODE_KEY] = NICE_VALUE;
    } else if (isDailyNice) {
      parameters[MODE_KEY] = DAILYNICE_VALUE;
    }

    int newPage = int.parse(p) + 1;
    parameters[PAGE_KEY] = newPage.toString();

    final uri = Uri(path: body, queryParameters: parameters);
    return uri.toString();
  }
}
