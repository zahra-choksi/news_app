import '../../domain/entity/news_entity.dart';

class NewsState {}

final class NewsInitial extends NewsState {}

final class NewsLoading extends NewsState{}

final class NewsLoaded extends NewsState{

  final List<NewsEntity> news;
  NewsLoaded(this.news);
}

final class NewsFailed extends NewsState{
  final String message;
  NewsFailed(this.message);
}