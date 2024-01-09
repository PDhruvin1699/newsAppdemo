import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class ArticleModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String sourceName;

  @HiveField(2)
  final String author;

  @HiveField(3)
  final String title;

  @HiveField(4)
  final String description;

  @HiveField(5)
  final String url;

  @HiveField(6)
  final String urlToImage;

  @HiveField(7)
  final String publishedAt;

  @HiveField(8)
  final String content;

  ArticleModel({
    required this.id,
    required this.sourceName,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  // factory ArticleModel.fromJson(Map<String, dynamic> json) {
  //   return ArticleModel(
  //     id: json['id']?.toString() ?? '0',
  //     sourceName: json['source']?['name'] as String? ?? 'Unknown Source',
  //     author: json['author'] as String? ?? 'Unknown Author',
  //     title: json['title'] as String? ?? 'No Title',
  //     description: json['description'] as String? ?? 'No Description',
  //     url: json['url'] as String? ?? 'No URL',
  //     urlToImage: json['urlToImage'] as String? ?? 'No Image',
  //     publishedAt: json['publishedAt'] as String? ?? 'No Date',
  //     content: json['content'] as String? ?? 'No Content',
  //   );
  // }
}
