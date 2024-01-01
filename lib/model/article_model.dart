// class ArticleModel {
//   final String id;
//   final String sourceName;
//   final String author;
//   final String title;
//   final String description;
//   final String url;
//   final String urlToImage;
//   final String publishedAt;
//   final String content;
//
//   ArticleModel({
//     required this.id,
//     required this.sourceName,
//     required this.author,
//     required this.title,
//     required this.description,
//     required this.url,
//     required this.urlToImage,
//     required this.publishedAt,
//     required this.content,
//   });
//
//   factory ArticleModel.fromJson(Map<String, dynamic> json) {
//     return ArticleModel(
//       id:json['id'] ?? "",
//       sourceName: json['source']['name'] ?? "",
//       author: json['author'] ?? "",
//       title: json['title'] ?? "",
//       description: json['description'] ?? "",
//       url: json['url'] ?? "",
//       urlToImage: json['urlToImage'] ?? "",
//       publishedAt: json['publishedAt'] ?? "",
//       content: json['content'] ?? "",
//     );
//   }
// }
class ArticleModel {
  final String id;
  final String sourceName;
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;
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

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      id: json['id'] ?? "",
      sourceName: json['source']['name'] ?? "",
      author: json['author'] ?? "",
      title: json['title'] ?? "",
      description: json['description'] ?? "",
      url: json['url'] ?? "",
      urlToImage: json['urlToImage'] ?? "",
      publishedAt: json['publishedAt'] ?? "",
      content: json['content'] ?? "",
    );
  }
}