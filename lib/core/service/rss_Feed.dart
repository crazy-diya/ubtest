import 'package:dio/dio.dart';
import 'package:webfeed_plus/domain/rss_feed.dart';

Future<RssFeed> fetchAndParseRssFeed(String url) async {
  try {
    final dio = Dio();
    final response = await dio.get(url);

    if (response.statusCode == 200) {
      final rssFeed = RssFeed.parse(response.data);
      return rssFeed;
    } else {
      throw Exception('Failed to load RSS feed');
    }
  } catch (e) {
    throw e;
  }
}