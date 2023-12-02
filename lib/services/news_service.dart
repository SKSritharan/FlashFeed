import 'dart:convert';
import 'package:http/http.dart' as http;

import '../constants.dart';
import '../models/article.dart';

class NewsService {
  Future<List<Article>> getTopHeadlines(
      {String country = 'in', int pageSize = 10}) async {
    final Map<String, String> parameters = {
      'country': country,
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

  String _buildQueryString(Map<String, String> parameters) {
    return parameters.entries
        .map((entry) => '${entry.key}=${entry.value}')
        .join('&');
  }
}

Future<List<Article>> getTopHeadlines(
    {String country = 'in', int pageSize = 10}) async {
  final Map<String, String> parameters = {
    'country': country,
    'pageSize': pageSize.toString(),
    'apiKey': AppConstants.apiKey,
  };

  final Uri uri = Uri.parse(
      '${AppConstants.baseUrl}/top-headlines?${_buildQueryString(parameters)}');

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
        throw Exception('Failed to fetch top headlines. ${data['message']}');
      }
    } else {
      throw Exception(
          'Failed to fetch top headlines. Status code: ${response.statusCode}');
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
