

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecase/fetch_news.dart';
import 'news_event.dart';
import 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final FetchNews fetchNews;
  final Connectivity connectivity;
  NewsBloc(
      this.fetchNews,
      this .connectivity
      ) : super(NewsInitial()) {
    on<LoadNewsEvent>((event, emit)async {
      emit(NewsLoading());
      try{
        final news = await fetchNews.execute(isConnected: event.isConnected);
        emit(NewsLoaded(news));
      }catch(e) {
        if (!event.isConnected) {
          emit(NewsFailed("No internet connection"));
        } else {
          emit(NewsFailed(e.toString()));
        }
      }
    });

    on<CheckConnectivityEvent>((event,emit) async {
      final connectivityResult = await Connectivity().checkConnectivity();
      if(connectivityResult == ConnectivityResult.none){
        emit(NewsFailed("No internet connection"));
      }
    });
  }
}
