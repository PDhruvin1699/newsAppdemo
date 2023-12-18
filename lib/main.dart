import 'package:blocnewsdemo/views/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blocnewsdemo/blocs/news_bloc.dart';
import 'package:blocnewsdemo/blocs/news_event.dart';
import 'package:blocnewsdemo/blocs/news_state.dart';

import 'contacts/news_repository.dart';
// Import your home screen

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final NewsRepository newsRepository = NewsRepository();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NewsBloc(newsRepository: newsRepository),
        ),
        // Add more BlocProviders if needed
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'News App',
        home: SplashScreen(),
      ),
    );
  }
}
