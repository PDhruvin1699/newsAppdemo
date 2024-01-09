
import 'package:hive/hive.dart';

import 'model/article_model.dart';



class ArticleModelAdapter extends TypeAdapter<ArticleModel> {
  @override
  final int typeId = 0;

  @override
  // ArticleModel read(BinaryReader reader) {
  //   final Map<dynamic, dynamic> data = reader.readMap();
  //   return ArticleModel.fromJson(Map<String, dynamic>.from(data));
  // }

  @override
  void write(BinaryWriter writer, ArticleModel obj) {
    writer
      ..write(obj.id)
      ..write(obj.sourceName)
      ..write(obj.author)
      ..write(obj.title)
      ..write(obj.description)
      ..write(obj.url)
      ..write(obj.urlToImage)
      ..write(obj.publishedAt)
      ..write(obj.content);
  }
  ArticleModel read(BinaryReader reader) {

    return ArticleModel(
      id: reader.read(),
      sourceName: reader.read(),
      author: reader.read(),
      title: reader.read(),
      description: reader.read(),
      url: reader.read(),
      urlToImage: reader.read(),
      publishedAt: reader.read(),
      content: reader.read(),
    );
  }

}
