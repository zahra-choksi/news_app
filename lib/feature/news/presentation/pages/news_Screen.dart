import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_edge/feature/news/presentation/bloc/news_event.dart';
import '../../../../core/themes/app_colors.dart';
import '../bloc/news_state.dart';
import '../bloc/news_bloc.dart';
import 'news_detail_screen.dart';


class HomeScreen extends StatefulWidget {
  static route ()=> MaterialPageRoute(builder: (context)=>const HomeScreen());
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late NewsBloc _newsBloc;
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  List<ConnectivityResult> ? _previousConnectivityResult;

  @override
  void initState() {
    super.initState();
    _newsBloc = context.read<NewsBloc>();
    _connectivitySubscription =
        Connectivity().
        onConnectivityChanged.
        listen((result) {
          Future.delayed(Duration.zero, () {
            if (_previousConnectivityResult != result) {
              if (result == ConnectivityResult.none) {
                _newsBloc.add(CheckConnectivityEvent());
              } else {
                _newsBloc.add(LoadNewsEvent(true));
              }
              _previousConnectivityResult = result;
            }
          });
        });
        }
      @override
      void dispose() {
        _connectivitySubscription.cancel();
        super.dispose();
      }

      @override
      Widget build(BuildContext context) {
        return Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            backgroundColor: AppColors.background,
            title: const Text("News App",
              style: TextStyle(
                  color: AppColors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold
              ),),
          ),

          body: BlocBuilder
          <NewsBloc, NewsState>(
              builder: (context, state) {
                if (state is NewsLoading) {
                  return const Center(child: CircularProgressIndicator(),);
                } else if (state is NewsLoaded) {

                  if (state.news.isEmpty) {
                    return const Center(child: Text(
                        "No News available"
                    ),);
                  }
                  return ListView.builder(
                      itemCount: state.news.length,
                      itemBuilder: (context, index) {
                        final article = state.news[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 4.0),
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,MaterialPageRoute(builder: (context)=>
                                  NewsDetailScreen(article:article ))
                              );
                            },
                            leading: CachedNetworkImage(
                              imageUrl: article.urlToImage,
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                              placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                            ),
                            title: Text(article.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(article.description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),

                          ),
                        );
                      });
                } else if (state is NewsFailed) {
                  return Center(child: Text(state.message),);
                }
                return const Center(child: Text('No data available'),);
              }),
        );
      }



}

