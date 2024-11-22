import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:news_edge/feature/news/data/datasource/local/news_local_data_source.dart';
import 'package:news_edge/feature/news/data/datasource/remote/news_remote_data_source.dart';
import 'package:news_edge/feature/news/data/repository/news_repository_impl.dart';
import 'package:news_edge/feature/news/domain/repository/news_repository.dart';
import 'package:news_edge/feature/news/domain/usecase/fetch_news.dart';
import 'package:news_edge/feature/news/presentation/bloc/news_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  final httpClient = http.Client();
   final sharedPreferences = await SharedPreferences.getInstance();

   sl.registerSingleton<Connectivity>(Connectivity());
   sl.registerSingleton<NewsRemoteDataSource>(NewsRemoteDataSourceImpl(httpClient));
   sl.registerSingleton<NewsLocalDataSource>(NewsLocalDataSourceImpl(sharedPreferences));
   sl.registerSingleton<NewsRepository>(NewsRepositoryImpl(
       remoteDataSource: sl<NewsRemoteDataSource>(),
       localDataSource: sl<NewsLocalDataSource>(),
   ));

   sl.registerSingleton<FetchNews>(FetchNews(sl<NewsRepository>()));
   sl.registerFactory(() => NewsBloc(
       sl<FetchNews>(),
       sl<Connectivity>()
   ));


}

