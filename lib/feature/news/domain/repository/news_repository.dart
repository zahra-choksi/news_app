import 'package:news_edge/feature/news/domain/entity/news_entity.dart';

abstract interface class NewsRepository {
  Future<List<NewsEntity>> getNews({required bool isConnected});
}