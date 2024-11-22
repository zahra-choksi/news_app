import 'package:news_edge/core/failure/failure.dart';
import 'package:news_edge/feature/news/data/datasource/local/news_local_data_source.dart';
import 'package:news_edge/feature/news/data/datasource/remote/news_remote_data_source.dart';
import 'package:news_edge/feature/news/domain/entity/news_entity.dart';
import 'package:news_edge/feature/news/domain/repository/news_repository.dart';

class NewsRepositoryImpl implements NewsRepository{
  final NewsRemoteDataSource remoteDataSource;
  final NewsLocalDataSource localDataSource;
  NewsRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
});

  @override
  Future<List<NewsEntity>> getNews({required bool isConnected})async {
    if(isConnected){
      try{
        final remoteNews = await remoteDataSource.fetchRemoteNews();
        await localDataSource.cacheNews(remoteNews);
        return remoteNews;
      }catch(e){
        throw Exception("Try to connect with your internet");
      }
    } else {
      return await localDataSource.fetchLocalNews();
    }
  }
}