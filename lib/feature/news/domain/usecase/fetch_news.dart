import 'package:news_edge/feature/news/domain/entity/news_entity.dart';
import 'package:news_edge/feature/news/domain/repository/news_repository.dart';

class FetchNews {
  final NewsRepository newsRepository;
  FetchNews(this.newsRepository);

  Future<List<NewsEntity>> execute({required bool isConnected}) async {
    return await newsRepository.getNews(isConnected: isConnected);
  }
}