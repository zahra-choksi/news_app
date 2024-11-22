import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_edge/feature/news/domain/entity/news_entity.dart';

import '../../../../core/themes/app_colors.dart';

class NewsDetailScreen extends StatelessWidget {
  final NewsEntity article;
  const  NewsDetailScreen({
    super.key,
    required this.article
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.background,
          title: const Text("News App",
            style: TextStyle(
              color: AppColors.white,
            ),
          ),
          leading: const BackButton(
            color: AppColors.white,
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding:  const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CachedNetworkImage(
                  imageUrl: article.urlToImage,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                  placeholder: (context,url)=>
                  const CircularProgressIndicator(),
                  errorWidget: (context,url,error)=>
                  const Icon(Icons.error),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  "Author :- ${article.author}",
                  style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600
                  ),
                ),
                const SizedBox(height: 8,),
                Text(
                  "Title :- ${article.title}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "Description :- ${article.description}",
                  style: const TextStyle(
                      fontSize: 16
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "Content :- ${article.content}",
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "Published At  :- ${article.publishedAt}",
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500
                  ),
                ),


              ],
            ),
          ),
        )
    );
  }
}
