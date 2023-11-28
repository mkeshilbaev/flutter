import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class NewsAggregator {
  final String apiKey;
  final String apiUrl;

  NewsAggregator(this.apiKey, this.apiUrl);

  Future<List<Map<String, dynamic>>> fetchNews() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final articles = data['articles'] as List<dynamic>;
        return List<Map<String, dynamic>>.from(articles);
      } else {
        throw Exception('Failed to load news');
      }
    } catch (e) {
      throw Exception('Error fetching news: $e');
    }
  }

  void saveNewsToFile(List<Map<String, dynamic>> news, String filePath) {
    final file = File(filePath);
    file.writeAsStringSync(jsonEncode(news));
  }

  List<Map<String, dynamic>> readNewsFromFile(String filePath) {
    final file = File(filePath);
    if (file.existsSync()) {
      final contents = file.readAsStringSync();
      final decodedData = jsonDecode(contents);
      return List<Map<String, dynamic>>.from(decodedData);
    } else {
      throw Exception('File not found');
    }
  }
}

void main() async {
  final apiKey = '410c0f4b2b49491a8e1609d9f601d3cc';
  final apiUrl = 'https://newsapi.org/v2/top-headlines?country=us&apiKey=$apiKey';

  final newsAggregator = NewsAggregator(apiKey, apiUrl);

  try {
    // Fetch news from the API
    final news = await newsAggregator.fetchNews();

    // Save news to a local file
    newsAggregator.saveNewsToFile(news, 'news_data.json');

    // Read news from the local file
    final storedNews = newsAggregator.readNewsFromFile('news_data.json');

    // Display the news
    print('Fetched News:');
    for (final article in storedNews) {
      print('Title: ${article['title']}');
      print('Description: ${article['description']}');
      print('URL: ${article['url']}');
      print('-----');
    }
  } catch (e) {
    print('Error: $e');
  }
}