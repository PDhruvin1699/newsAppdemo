//
// import 'package:blocnewsdemo/views/splash.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:blocnewsdemo/blocs/news_bloc.dart';
//
// import 'package:hive/hive.dart';
// import 'package:hive_flutter/hive_flutter.dart';
//
//
// import 'adeptor.dart';
// import 'contacts/news_repository.dart';
// import 'model/article_model.dart';
//
//
//
// // Import your home screen
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Hive.initFlutter();
//   Hive.registerAdapter(ArticleModelAdapter());
//
//   // Make sure to open the box after registering the adapter
//   await Hive.openBox<ArticleModel>('articlesBox');
//
//   runApp(MyApp());
// }
//
// //
//
//
// class MyApp extends StatelessWidget {
//   final NewsRepository newsRepository = NewsRepository();
//
//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider(
//           create: (context) => NewsBloc(newsRepository: newsRepository),
//         ),
//         // Add more BlocProviders if needed
//       ],
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//
//         title: 'News App',
//         home: SplashScreen(),
//       ),
//     );
//   }
// }
import 'package:blocnewsdemo/views/home.dart';
import 'package:blocnewsdemo/views/login.dart';
import 'package:blocnewsdemo/views/signup.dart';
import 'package:blocnewsdemo/views/syn.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'blocs/authbloc.dart';
import 'blocs/news_bloc.dart';
import 'blocs/thembloc.dart';
import 'blocs/themeevent.dart';
import 'views/splash.dart';
// Import your home screen
import 'adeptor.dart';
import 'contacts/news_repository.dart';
import 'model/article_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  Hive.registerAdapter(ArticleModelAdapter());

  // Make sure to open the box after registering the adapter
  await Hive.openBox<ArticleModel>('articlesBox');

  runApp(MyApp());
}

// class MyApp extends StatelessWidget {
//   final NewsRepository newsRepository = NewsRepository();
//
//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider(
//           create: (context) => NewsBloc(newsRepository: newsRepository),
//         ),
//         // Add more BlocProviders if needed
//       ],
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         title: 'News App',
//         initialRoute: '/',
//         routes: {
//           '/': (context) => SplashScreen(),
//           // '/sync': (context) => SyncScreen(),
//           '/home': (context) => HomePage(),
//         },
//       ),
//     );
//   }
// }
///working below
class MyApp extends StatelessWidget {
  final NewsRepository newsRepository = NewsRepository();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(),
        ),
        BlocProvider(
          create: (context) => NewsBloc(newsRepository: newsRepository),
        ),
        BlocProvider(
          create: (context) => ThemeBloc(),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'News App',
            theme: themeState.theme, // Use the selected theme
            initialRoute: '/',
            routes: {
              '/': (context) => SplashScreen(),
              '/signup':(context) => SignUpScreen(),
              '/home': (context) => BlocProvider.value(
                value: context.read<ThemeBloc>(),
                child: HomePage(),
              ),
            },
          );
        },
      ),
    );
  }
}
// class MyApp extends StatelessWidget {
//   final NewsRepository newsRepository = NewsRepository();
//
//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider<AuthCubit>(
//           create: (context) => AuthCubit(),
//         ),
//         BlocProvider(
//           create: (context) => NewsBloc(newsRepository: newsRepository),
//         ),
//         BlocProvider(
//           create: (context) => ThemeBloc(),
//         ),
//       ],
//       child: BlocBuilder<ThemeBloc, ThemeState>(
//         builder: (context, themeState) {
//           return MaterialApp(
//             debugShowCheckedModeBanner: false,
//             title: 'News App',
//             theme: themeState.theme, // Use the selected theme
//             initialRoute: '/',
//             routes: {
//               '/': (context) {
//                 // Check authentication status and navigate accordingly
//                 context.read<AuthCubit>().checkAuthStatus();
//                 return SplashScreen();
//               },
//               '/home': (context) => BlocProvider.value(
//                 value: context.read<ThemeBloc>(),
//                 child: HomePage(),
//               ),
//               '/signup': (context) => BlocProvider.value(
//                 value: context.read<AuthCubit>(),
//                 child: SignUpScreen(),
//               ),
//             },
//           );
//         },
//       ),
//     );
//   }
// }


// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   final NewsRepository newsRepository = NewsRepository();
//
//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider(
//           create: (context) => NewsBloc(newsRepository: newsRepository),
//         ),
//         BlocProvider(
//           create: (context) => ThemeBloc(),
//         ),
//         BlocProvider(
//           create: (context) => AuthBloc(), // Add AuthBloc for authentication
//         ),
//       ],
//       child: BlocBuilder<ThemeBloc, ThemeState>(
//         builder: (context, themeState) {
//           return MaterialApp(
//             debugShowCheckedModeBanner: false,
//             title: 'News App',
//             theme: themeState.theme,
//             initialRoute: '/',
//             routes: {
//               '/': (context) => SplashScreen(),
//               '/login': (context) => BlocProvider.value(
//                 value: context.read<AuthBloc>(),
//                 child: LoginPage(),
//               ),
//               '/signup': (context) => BlocProvider.value(
//                 value: context.read<AuthBloc>(),
//                 child: SignupPage(),
//               ),
//               '/home': (context) => BlocProvider.value(
//                 value: context.read<ThemeBloc>(),
//                 child: HomePage(),
//               ),
//             },
//           );
//         },
//       ),
//     );
//   }
// }
