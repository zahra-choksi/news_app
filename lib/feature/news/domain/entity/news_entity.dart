class NewsEntity {

  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final DateTime publishedAt;
  final String content;

  NewsEntity({

    required this.author,
    required this.title,
    required this.description,
    required this.urlToImage,
    required this.url,
    required this.content,
    required this.publishedAt,
  });

}