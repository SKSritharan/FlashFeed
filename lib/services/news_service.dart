import 'dart:convert';
import 'package:http/http.dart' as http;

import '../constants.dart';
import '../models/article.dart';
import '../models/source.dart';

class NewsService {
  Future<List<Source>> getNewsSources(
      {String country = '', String category = '', int pageSize = 10}) async {
    final Map<String, String> parameters = {
      'category': category,
      'country': country,
      // 'pageSize': pageSize.toString(),
      'apiKey': AppConstants.apiKey,
    };

    final Uri uri = Uri.parse(
        '${AppConstants.baseUrl}/top-headlines/sources?${_buildQueryString(parameters)}');

    return _fetchSources(uri);
  }

  Future<List<Article>> getTopHeadlines(
      {String country = 'us', // ae, ar, at, au, be, bg, br, ca, ch, cn, co, cu, cz, de, eg, fr, gb, gr, hk, hu, id, ie, il, in, it, jp, kr, lt, lv, ma, mx, my, ng, nl, no, nz, ph, pl, pt, ro, rs, ru, sa, se, sg, si, sk, th, tr, tw, ua, us, ve, za
      String category = '', //business, entertainment, general, health, science, sports, technology
      String sources = '',
      int pageSize = 10}) async {
    final Map<String, String> parameters = {
      'category': category,
      'country': country,
      'sources': sources,
      'pageSize': pageSize.toString(),
      'apiKey': AppConstants.apiKey,
    };

    final Uri uri = Uri.parse(
        '${AppConstants.baseUrl}/top-headlines?${_buildQueryString(parameters)}');

    return _fetchArticles(uri);
  }

  Future<List<Article>> getEverything(
      {String query = '', int pageSize = 10}) async {
    final Map<String, String> parameters = {
      'q': query,
      'pageSize': pageSize.toString(),
      'apiKey': AppConstants.apiKey,
    };

    final Uri uri = Uri.parse(
        '${AppConstants.baseUrl}/everything?${_buildQueryString(parameters)}');

    return _fetchArticles(uri);
  }

  Future<List<Article>> _fetchArticles(Uri uri) async {
    try {
      final http.Response response = await http.get(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data['status'] == 'ok') {
          final List<dynamic> articlesData = data['articles'];
          return articlesData
              .map((article) => Article.fromJson(article))
              .toList();
        } else {
          throw Exception('Failed to fetch articles. ${data['message']}');
        }
      } else {
        throw Exception(
            'Failed to fetch articles. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<List<Source>> _fetchSources(Uri uri) async {
    try {
      final http.Response response = await http.get(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data['status'] == 'ok') {
          final List<dynamic> sourcesData = data['sources'];
          return sourcesData
              .map((article) => Source.fromJson(article))
              .toList();
        } else {
          throw Exception('Failed to fetch articles. ${data['message']}');
        }
      } else {
        throw Exception(
            'Failed to fetch articles. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  String _buildQueryString(Map<String, String> parameters) {
    return parameters.entries
        .map((entry) => '${entry.key}=${entry.value}')
        .join('&');
  }
}
