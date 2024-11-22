import 'dart:convert';
import 'package:news_edge/feature/news/data/model/news_model.dart';
import 'package:http/http.dart' as http;

abstract interface class NewsRemoteDataSource {
  Future<List<NewsModel>> fetchRemoteNews ();
}

class NewsRemoteDataSourceImpl implements NewsRemoteDataSource{
  final http.Client client;
  NewsRemoteDataSourceImpl(this.client);

  @override
  Future<List<NewsModel>> fetchRemoteNews() async {
    final url = Uri.parse("https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=6cb62709badb4567a41baa92822ee339");
    final response = await client.get(url);
    if (response.statusCode == 200) {

      final  data = await jsonDecode(response.body);

      return (data['articles'] as List).map((item){
        return NewsModel.fromJson(item);
      }).toList();
    } else {
      throw Exception('Failed to load news from Api');
    }
  }
}