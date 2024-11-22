import 'dart:convert';

import 'package:news_edge/feature/news/data/model/news_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class NewsLocalDataSource {
  Future<List<NewsModel>> fetchLocalNews();
  Future<void> cacheNews(List<NewsModel> newsModel);
}

class NewsLocalDataSourceImpl implements NewsLocalDataSource{
final SharedPreferences preferences;
NewsLocalDataSourceImpl(this.preferences);

  @override
  Future<void> cacheNews(List<NewsModel> newsModel)async {
    final jsonString = json.encode(newsModel.map((item) => item.toJson()).toList());
    await preferences.setString('cached News', jsonString);
  }

  @override
  Future<List<NewsModel>> fetchLocalNews() async {
    final jsonString =  preferences.getString('cached News');
    if(jsonString != null){
      final List<dynamic> jsonData = jsonDecode(jsonString);
      return jsonData.map((item) => NewsModel.fromJson(item)).toList();
    }
    else {
      throw Exception("No local data available");
    }
  }


}