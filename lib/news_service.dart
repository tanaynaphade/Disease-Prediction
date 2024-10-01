import 'dart:convert';
import 'package:http/http.dart' as http;
import 'news_article.dart';

class NewsService {
  final String apiKey = '6b246d6cd03e4acab4da3d0b6076dd8f'; // Replace with your API Key

  Future<List<NewsArticle>> fetchAgricultureNews(String country) async {
    // Use agriculture-related keywords for global news or local news
    final String url = country == 'global'
        ? 'https://newsapi.org/v2/everything?q=agriculture&apiKey=$apiKey' // Query for global agriculture news
        : 'https://newsapi.org/v2/top-headlines?country=$country&q=agriculture&apiKey=$apiKey'; // Query for local agriculture news

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List articles = data['articles'];
      return articles.map((json) => NewsArticle.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load agriculture news');
    }
  }
}
