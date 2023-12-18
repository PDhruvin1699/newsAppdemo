import 'dart:convert';
import 'package:http/http.dart' as http;


import '../model/article_model.dart';

// class NewsRepository {
//   Future<List<ArticleModel>> getNews() async {
//     try {
//       var Api_key ="4c4080f696184e9b9c50b748c397fd87";
//       final response = await http.get(Uri.parse('https://newsapi.org/v2/top-headlines?country=us&apiKey=$Api_key'));
//
//       if (response.statusCode == 200) {
//         final Map<String, dynamic> jsonResponse = json.decode(response.body);
//
//         // Check if the 'articles' key exists and if it's a list
//         if (jsonResponse.containsKey('articles') && jsonResponse['articles'] is List<dynamic>) {
//           final List<dynamic> jsonList = jsonResponse['articles'];
//           final List<ArticleModel> articles = jsonList.map((json) => ArticleModel.fromJson(json)).toList();
//           return articles;
//         } else {
//           throw Exception('Invalid API response format: Missing or invalid "articles" key.');
//         }
//       } else {
//         throw Exception('Failed to fetch news. Status code: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error fetching news: $e');
//       return [];
//     }
//   }
// }
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/article_model.dart';

class NewsRepository {
  // static const Map<String, String> headers = {'User-Agent': 'blocnewsdemo'};
  static const String apiKey = "4c4080f696184e9b9c50b748c397fd87";
  static const Map<String, String> headers = {'User-Agent': 'blocnewsdemo/1.0'};

  Future<List<ArticleModel>> getNews() async {
    try {

      final response = await http.get(
        Uri.parse('https://newsapi.org/v2/top-headlines?country=in&apiKey=$apiKey'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        // Check if the 'articles' key exists and if it's a list
        if (jsonResponse.containsKey('articles') && jsonResponse['articles'] is List<dynamic>) {
          final List<dynamic> jsonList = jsonResponse['articles'];
          final List<ArticleModel> articles = jsonList.map((json) => ArticleModel.fromJson(json)).toList();
          return articles;
        } else {
          throw Exception('Invalid API response format: Missing or invalid "articles" key.');
        }
      } else {
        throw Exception('Failed to fetch news. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching news: $e');
      return [];
    }
  }
}