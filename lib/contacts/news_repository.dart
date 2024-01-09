import 'dart:convert';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import '../model/article_model.dart';
//
// class NewsRepository {
//   static const String apiKey = "4c4080f696184e9b9c50b748c397fd87";
//   static const Map<String, String> headers = {'User-Agent': 'blocnewsdemo/1.0'};
//
//   Future<List<ArticleModel>> getNews() async {
//     try {
//       final response = await http.get(
//         Uri.parse(
//             'https://newsapi.org/v2/top-headlines?country=us&apiKey=$apiKey'),
//         headers: headers,
//       );
//
//       if (response.statusCode == 200) {
//         final Map<String, dynamic> jsonResponse = json.decode(response.body);
//
//         // Check if the 'articles' key exists and if it's a list
//         if (jsonResponse.containsKey('articles') &&
//             jsonResponse['articles'] is List<dynamic>) {
//           final List<dynamic> jsonList = jsonResponse['articles'];
//           final List<ArticleModel> articles =
//               jsonList.map((json) => ArticleModel.fromJson(json)).toList();
//           return articles;
//         } else {
//           throw Exception(
//               'Invalid API response format: Missing or invalid "articles" key.');
//         }
//       } else {
//         throw Exception(
//             'Failed to fetch news. Status code: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error fetching news: $e');
//       return [];
//     }
//   }
// }
import 'dart:convert';
import 'package:http/http.dart' as http;
//
//
// class NewsRepository {
//   static const String apiKey = "4c4080f696184e9b9c50b748c397fd87";
//   static const Map<String, String> headers = {'User-Agent': 'blocnewsdemo/1.0'};
//   static const String baseUrl = 'https://newsapi.org/v2/top-headlines?country=us&apiKey=$apiKey';
//
//   Future<List<ArticleModel>> getNews({int page = 1}) async {
//     try {
//       final response = await http.get(
//         Uri.parse('$baseUrl&page=$page'),
//         headers: headers,
//       );
//
//       if (response.statusCode == 200) {
//         final Map<String, dynamic> jsonResponse = json.decode(response.body);
//
//         // Check if the 'articles' key exists and if it's a list
//         if (jsonResponse.containsKey('articles') &&
//             jsonResponse['articles'] is List<dynamic>) {
//           final List<dynamic> jsonList = jsonResponse['articles'];
//           final List<ArticleModel> articles =
//           jsonList.map((json) => ArticleModel.fromJson(json)).toList();
//           return articles;
//         } else {
//           throw Exception(
//               'Invalid API response format: Missing or invalid "articles" key.');
//         }
//       } else {
//         throw Exception(
//             'Failed to fetch news. Status code: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error fetching news: $e');
//       return [];
//     }
//   }
// }
import 'dart:convert';
import 'package:dio/dio.dart';
//
// class NewsRepository {
//   static const String apiKey = "4c4080f696184e9b9c50b748c397fd87";
//   static const String baseUrl = 'https://newsapi.org/v2/top-headlines?country=us';
//   static const Map<String, String> headers = {'User-Agent': 'blocnewsdemo/1.0'};
//
//   final Dio _dio = Dio();
//
//   Future<List<ArticleModel>> getNews({int page = 1}) async {
//     try {
//       final response = await _dio.get(
//         '$baseUrl&apiKey=$apiKey&page=$page',
//         options: Options(headers: headers),
//       );
//
//       if (response.statusCode == 200) {
//         final Map<String, dynamic> jsonResponse = response.data;
//
//         // Check if the 'articles' key exists and if it's a list
//         if (jsonResponse.containsKey('articles') &&
//             jsonResponse['articles'] is List<dynamic>) {
//           final List<dynamic> jsonList = jsonResponse['articles'];
//           final List<ArticleModel> articles =
//           jsonList.map((json) => ArticleModel.fromJson(json)).toList();
//           return articles;
//         } else {
//           throw Exception(
//               'Invalid API response format: Missing or invalid "articles" key.');
//         }
//       } else {
//         throw Exception(
//             'Failed to fetch news. Status code: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error fetching news: $e');
//       return [];
//     }
//   }
// }
///
class NewsRepository {
  static const String apiKey = "4c4080f696184e9b9c50b748c397fd87";
  static const String baseUrl =
      'https://newsapi.org/v2/top-headlines?country=in';
  static const Map<String, String> headers = {'User-Agent': 'blocnewsdemo/1.0'};

  final Dio _dio = Dio();

  Future<List<ArticleModel>> getNews({int page = 1}) async {
    try {
      final response = await _dio.get(
        '$baseUrl&apiKey=$apiKey&page=$page',
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = response.data;

        if (jsonResponse.containsKey('articles') &&
            jsonResponse['articles'] is List<dynamic>) {
          final List<dynamic> jsonList = jsonResponse['articles'];
          final List<ArticleModel> articles =
          jsonList.map((json) => ArticleModel.fromJson(json)).toList();

          await _saveArticlesToHive(articles);

          return articles;
        } else {
          throw Exception(
              'Invalid API response format: Missing or invalid "articles" key.');
        }
      } else {
        final List<ArticleModel> offlineArticles = await _getOfflineArticles();
        return offlineArticles;
      }
    } catch (e) {
      print('Error fetching news: $e');
      final List<ArticleModel> offlineArticles = await _getOfflineArticles();
      return offlineArticles;
    }
  }

  // Future<void> _saveArticlesToHive(List<ArticleModel> articles) async {
  //   final box = await Hive.openBox<ArticleModel>('articlesBox');
  //   await box.clear();
  //   await box.addAll(articles);
  //
  //   print('Saved articles:');
  //   for (ArticleModel article in articles) {
  //     print(article.title);
  //   }
  // }
  Future<void> _saveArticlesToHive(List<ArticleModel> articles) async {
    final box = await Hive.openBox<ArticleModel>('articlesBox');

    for (ArticleModel article in articles) {
      final bool articleExists = box.values.any((a) => a.urlToImage == article.urlToImage);

      if (articleExists) {
        // Article with the same urlToImage already exists, update it
        final int index = box.values.toList().indexWhere((a) => a.urlToImage == article.urlToImage);
        box.putAt(index, article);
      } else {
        // Article with this urlToImage doesn't exist, add it
        box.add(article);
      }

      // Download and save the image
      await _downloadAndSaveImage(article.urlToImage);
    }

    print('Saved/Updated articles:');
    for (ArticleModel article in box.values) {
      print(article.title);
    }
  }

  Future<void> synchronizeData() async {
    List<ArticleModel> articles = await getNews();

    for (ArticleModel article in articles) {
      await _downloadAndSaveImage(article.urlToImage);
    }
  }

  Future<void> _downloadAndSaveImage(String imageUrl) async {
    try {
      if (imageUrl != null && imageUrl.isNotEmpty) {
        final response = await Dio().get(
          imageUrl,
          options: Options(responseType: ResponseType.bytes),
        );

        final Directory appDocDir = await getApplicationDocumentsDirectory();
        final String fileName = imageUrl.split('/').last; // Use the last part of the URL as the filename
        final String filePath = '${appDocDir.path}/images/$fileName';

        await Directory('${appDocDir.path}/images').create(recursive: true);
        File(filePath).writeAsBytesSync(response.data);

        print('Image saved to: $filePath');
      }
    } catch (e) {
      print('Error downloading image: $e');
    }
  }

  Future<List<ArticleModel>> _getOfflineArticles() async {
    try {
      if (await isOnline()) {
        // If online, return an empty list to trigger fetching from API
        return [];
      } else {
        // If offline, fetch data from Hive
        final box = await Hive.openBox<ArticleModel>('articlesBox');
        return box.values.toList();
      }
    } on DioError catch (e) {
      // Handle Dio errors (e.g., connection timeout)
      print('Dio Error fetching offline articles: $e');
      return []; // Return an empty list or handle the error based on your requirements
    } catch (e) {
      // Handle other unexpected errors
      print('Unexpected Error fetching offline articles: $e');
      return []; // Return an empty list or handle the error based on your requirements
    }
  }



  Future<bool> isOnline() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
    // Implement your logic to check if the device is online
    // For example, you can use the connectivity package or check if the Dio library throws an error
    // when trying to make a request.
    // Return true if online, false if offline.
    // return true; // Placeholder, replace with your logic.
  }

}