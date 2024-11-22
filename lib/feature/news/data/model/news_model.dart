

import 'package:news_edge/feature/news/domain/entity/news_entity.dart';

class NewsModel extends NewsEntity{
  NewsModel({
    required super.author,
    required super.title,
    required super.description,
    required super.urlToImage,
    required super.url,
    required super.content,
    required super.publishedAt,

  });

  factory NewsModel.fromJson(Map<String,dynamic> json){
    return NewsModel(

      author: json ['author'] ?? '',
      title: json ['title'] ?? '',
      description: json ['description'] ?? '',
      urlToImage: json ['urlToImage'] ?? '',
      url: json['url'] ?? '',
      content: json['content'] ?? '',
      publishedAt: DateTime.parse(json ['publishedAt'] ?? ''),
    );
  }

  Map<String,dynamic> toJson(){
    return{

      'author' : author,
      'title' : title,
      'description':description,
      'urlToImage' : urlToImage,
      'url':url,
      'content':content,
      'publishedAt':publishedAt.toIso8601String()
    };
  }
}