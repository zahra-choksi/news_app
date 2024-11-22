import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_edge/feature/news/presentation/bloc/news_bloc.dart';
import 'package:news_edge/feature/news/presentation/bloc/news_event.dart';
import 'package:news_edge/feature/news/presentation/pages/news_Screen.dart';
import 'package:news_edge/feature/news/presentation/pages/splash_screen.dart';
import 'package:news_edge/init_dependency.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();

  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key,});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_)=> NewsBloc(
            sl(),sl())..add(LoadNewsEvent(true))),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'News App ',

        home:  SplashScreen()
      ),
    );
  }
}
