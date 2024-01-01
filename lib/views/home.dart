import 'dart:math';

import 'package:blocnewsdemo/contacts/news_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blocnewsdemo/blocs/news_bloc.dart';
import 'package:blocnewsdemo/blocs/news_event.dart';
import 'package:blocnewsdemo/blocs/news_state.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../model/article_model.dart';
import '../utiles/shiimer.dart';
import 'details.dart';
//
//
// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'News',
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//         backgroundColor: Colors.white38,
//         elevation: 0, // Removes the shadow
//         leading: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Image.asset(
//             'images/21601.png', // Replace with the actual path to your image
//             height: 24.0, // Adjust the height as needed
//             width: 24.0, // Adjust the width as needed
//           ),
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.refresh),
//             onPressed: () {
//               BlocProvider.of<NewsBloc>(context).add(FetchNews());
//             },
//           ),
//         ],
//       ),
//       body: BlocBuilder<NewsBloc, NewsState>(
//         builder: (context, state) {
//           if (state is NewsInitial) {
//             BlocProvider.of<NewsBloc>(context).add(FetchNews());
//           } else if (state is NewsLoaded) {
//             return ListView.builder(
//               itemCount: state.articles.length,
//               itemBuilder: (context, index) {
//                 final article = state.articles[index];
//
//                 return InkWell(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => DetailsPage(article: article),
//                       ),
//                     );
//                   },
//                   child: Card(
//                     elevation: 7,
//                     margin: EdgeInsets.all(8.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: [
//                         ClipRRect(
//                           borderRadius: BorderRadius.only(
//                             topLeft: Radius.circular(8.0),
//                             topRight: Radius.circular(8.0),
//                           ),
//
//                           child: Image.network(
//                             article.urlToImage,
//                             height: 150.0,
//                             fit: BoxFit.cover,
//                             errorBuilder: (BuildContext context, Object error,
//                                 StackTrace? stackTrace) {
//                               // Handle the error here, you can show a placeholder or an error message.
//                               return Container(
//                                 color: Colors.white38, // Placeholder color
//                                 height: 150.0,
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Center(
//                                       child: Icon(
//                                         Icons.error,
//                                         color: Colors.red,
//                                       ),
//                                     ),
//                                     Center(
//                                       child: Text('No image'),
//                                     )
//                                   ],
//                                 ),
//                               );
//                             },
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.all(12.0),
//                           child: Text(
//                             article.title,
//                             style: TextStyle(
//                                 fontSize: 18.0, fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             TextButton(
//                               onPressed: () {
//                                 // Add your 'More' button logic here
//                               },
//                               child: Row(
//                                 children: [
//                                   Text(
//                                     'More',
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.w500,
//                                     ),
//                                   ),
//                                   Icon(Icons.chevron_right),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         )
//
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             );
//           } else if (state is NewsError) {
//             return Center(
//               child: Text(
//                 state.errorMessage,
//                 style: TextStyle(color: Colors.red),
//               ),
//             );
//           }
//           return Center(
//             child: CircularProgressIndicator(),
//           );
//         },
//       ),
//     );
//   }
// }
//

// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
//
// class HomePage extends StatelessWidget {
//   final PageController _pageController = PageController();
//   final int itemsPerPage = 3;
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => NewsBloc(newsRepository: NewsRepository()),
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text(
//             'News',
//             style: TextStyle(fontWeight: FontWeight.bold),
//           ),
//           centerTitle: true,
//           backgroundColor: Colors.white38,
//           elevation: 0,
//           leading: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Image.asset(
//               'images/21601.png',
//               height: 24.0,
//               width: 24.0,
//             ),
//           ),
//           actions: [
//             IconButton(
//               icon: Icon(Icons.refresh),
//               onPressed: () {
//                 BlocProvider.of<NewsBloc>(context).add(FetchNews());
//               },
//             ),
//           ],
//         ),
//         body: BlocBuilder<NewsBloc, NewsState>(
//           builder: (context, state) {
//             if (state is NewsInitial) {
//               BlocProvider.of<NewsBloc>(context).add(FetchNews());
//             } else if (state is NewsLoaded) {
//               return PageView.builder(
//                 controller: _pageController,
//                 onPageChanged: (page) {
//                   if (page == state.currentPage - 1 && state.articles.length % itemsPerPage == 0) {
//                     BlocProvider.of<NewsBloc>(context).add(FetchNews(page: state.currentPage + 1));
//                   }
//                 },
//                 itemCount: (state.articles.length / 3).ceil(),
//                 itemBuilder: (context, pageIndex) {
//                   final start = pageIndex * 3;
//                   final end = (pageIndex + 1) * 3;
//                   final pageArticles = state.articles.sublist(start, min(end, state.articles.length));
//
//                   return ListView.builder(
//                     itemCount: pageArticles.length,
//                     itemBuilder: (context, index) {
//                       final article = pageArticles[index];
//
//                       return InkWell(
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => DetailsPage(article: article),
//                             ),
//                           );
//                         },
//                         child: Card(
//                           elevation: 7,
//                           margin: EdgeInsets.all(8.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.stretch,
//                             children: [
//                               ClipRRect(
//                                 borderRadius: BorderRadius.only(
//                                   topLeft: Radius.circular(8.0),
//                                   topRight: Radius.circular(8.0),
//                                 ),
//                                 child: Image.network(
//                                   article.urlToImage,
//                                   height: 150.0,
//                                   fit: BoxFit.cover,
//                                   errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
//                                     return Container(
//                                       color: Colors.white38,
//                                       height: 150.0,
//                                       child: Row(
//                                         mainAxisAlignment: MainAxisAlignment.center,
//                                         children: [
//                                           Center(
//                                             child: Icon(
//                                               Icons.error,
//                                               color: Colors.red,
//                                             ),
//                                           ),
//                                           Center(
//                                             child: Text('No image'),
//                                           )
//                                         ],
//                                       ),
//                                     );
//                                   },
//                                 ),
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.all(12.0),
//                                 child: Text(
//                                   article.title,
//                                   style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
//                                 ),
//                               ),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   TextButton(
//                                     onPressed: () {
//                                       // Add your 'More' button logic here
//                                     },
//                                     child: Row(
//                                       children: [
//                                         Text(
//                                           'More',
//                                           style: TextStyle(
//                                             fontSize: 16,
//                                             fontWeight: FontWeight.w500,
//                                           ),
//                                         ),
//                                         Icon(Icons.chevron_right),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               )
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 },
//               );
//             } else if (state is NewsError) {
//               return Center(
//                 child: Text(
//                   state.errorMessage,
//                   style: TextStyle(color: Colors.red),
//                 ),
//               );
//             }
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
///
// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';
//
// class HomePage extends StatelessWidget {
//   final PageController _pageController = PageController();
//   final int itemsPerPage = 3;
//
//   @override
//   Widget build(BuildContext context) {
//     final _currentPage = ValueNotifier<double>(0);
//
//     return BlocProvider(
//       create: (context) => NewsBloc(newsRepository: NewsRepository()),
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text(
//             'News',
//             style: TextStyle(fontWeight: FontWeight.bold),
//           ),
//           centerTitle: true,
//           backgroundColor: Colors.white38,
//           elevation: 0,
//           leading: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Image.asset(
//               'images/21601.png',
//               height: 24.0,
//               width: 24.0,
//             ),
//           ),
//           actions: [
//             IconButton(
//               icon: Icon(Icons.refresh),
//               onPressed: () {
//                 BlocProvider.of<NewsBloc>(context).add(FetchNews());
//               },
//             ),
//           ],
//         ),
//         body: BlocBuilder<NewsBloc, NewsState>(
//           builder: (context, state) {
//             if (state is NewsInitial) {
//               BlocProvider.of<NewsBloc>(context).add(FetchNews());
//             } else if (state is NewsLoaded) {
//               return Column(
//                 children: [
//                   Expanded(
//                     child: NotificationListener<ScrollNotification>(
//                       onNotification: (ScrollNotification scrollInfo) {
//                         if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
//                           BlocProvider.of<NewsBloc>(context).add(FetchNews(page: state.currentPage + 1));
//                         }
//                         return false;
//                       },
//                       child: ListView.builder(
//                         controller: _pageController,
//                         itemCount: (state.articles.length / itemsPerPage).ceil(),
//                         itemBuilder: (context, pageIndex) {
//                           final start = pageIndex * itemsPerPage;
//                           final end = min((pageIndex + 1) * itemsPerPage, state.articles.length);
//                           final pageArticles = state.articles.sublist(start, end);
//
//                           return Column(
//                             children: pageArticles.map((article) {
//                               return InkWell(
//                                 onTap: () {
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) => DetailsPage(article: article),
//                                     ),
//                                   );
//                                 },
//                                 child: Card(
//                                   elevation: 7,
//                                   margin: EdgeInsets.all(8.0),
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                                     children: [
//                                       ClipRRect(
//                                         borderRadius: BorderRadius.only(
//                                           topLeft: Radius.circular(8.0),
//                                           topRight: Radius.circular(8.0),
//                                         ),
//                                         child: Image.network(
//                                           article.urlToImage,
//                                           height: 150.0,
//                                           fit: BoxFit.cover,
//                                           errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
//                                             return Container(
//                                               color: Colors.white38,
//                                               height: 150.0,
//                                               child: Row(
//                                                 mainAxisAlignment: MainAxisAlignment.center,
//                                                 children: [
//                                                   Center(
//                                                     child: Icon(
//                                                       Icons.error,
//                                                       color: Colors.red,
//                                                     ),
//                                                   ),
//                                                   Center(
//                                                     child: Text('No image'),
//                                                   )
//                                                 ],
//                                               ),
//                                             );
//                                           },
//                                         ),
//                                       ),
//                                       Padding(
//                                         padding: EdgeInsets.all(12.0),
//                                         child: Text(
//                                           article.title,
//                                           style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
//                                         ),
//                                       ),
//                                       Row(
//                                         mainAxisAlignment: MainAxisAlignment.start,
//                                         mainAxisSize: MainAxisSize.min,
//                                         children: [
//                                           TextButton(
//                                             onPressed: () {
//                                               // Add your 'More' button logic here
//                                             },
//                                             child: Row(
//                                               children: [
//                                                 Text(
//                                                   'More',
//                                                   style: TextStyle(
//                                                     fontSize: 16,
//                                                     fontWeight: FontWeight.w500,
//                                                   ),
//                                                 ),
//                                                 Icon(Icons.chevron_right),
//                                               ],
//                                             ),
//                                           ),
//                                         ],
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               );
//                             }).toList(),
//                           );
//                         },
//                       ),
//                     ),
//                   ),
//                   Container(
//                     decoration: BoxDecoration(
//                       border: Border.all(
//                         color: Colors.grey,
//                         width: 1.0,
//                       ),
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                     margin: EdgeInsets.all(8.0),
//                     padding: EdgeInsets.all(8.0),
//                     child: SmoothPageIndicator(
//                       controller: _pageController,
//                       count: (state.articles.length / itemsPerPage).ceil(),
//                       effect: ExpandingDotsEffect(
//                         activeDotColor: Colors.black,
//                         dotColor: Colors.grey,
//                         dotHeight: 8.0,
//                         dotWidth: 8.0,
//                         spacing: 4.0,
//                       ),
//                     ),
//                   ),
//                 ],
//               );
//             } else if (state is NewsError) {
//               return Center(
//                 child: Text(
//                   state.errorMessage,
//                   style: TextStyle(color: Colors.red),
//                 ),
//               );
//             }
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           },
//         ),
//       ),
//     );
//   }
// // }
// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';
//
// class HomePage extends StatelessWidget {
//   final PageController _pageController = PageController();
//   final int itemsPerPage = 3;
//
//   @override
//   Widget build(BuildContext context) {
//     final _currentPage = ValueNotifier<double>(0);
//
//     return BlocProvider(
//       create: (context) => NewsBloc(newsRepository: NewsRepository()),
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text(
//             'News',
//             style: TextStyle(fontWeight: FontWeight.bold),
//           ),
//           centerTitle: true,
//           backgroundColor: Colors.white38,
//           elevation: 0,
//           leading: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Image.asset(
//               'images/21601.png',
//               height: 24.0,
//               width: 24.0,
//             ),
//           ),
//           actions: [
//             IconButton(
//               icon: Icon(Icons.refresh),
//               onPressed: () {
//                 BlocProvider.of<NewsBloc>(context).add(FetchNews());
//               },
//             ),
//           ],
//         ),
//         body: BlocBuilder<NewsBloc, NewsState>(
//           builder: (context, state) {
//             if (state is NewsInitial) {
//               BlocProvider.of<NewsBloc>(context).add(FetchNews());
//             } else if (state is NewsLoaded) {
//               return Column(
//                 children: [
//                   Expanded(
//                     child: NotificationListener<ScrollNotification>(
//                       onNotification: (ScrollNotification scrollInfo) {
//                         if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
//                           BlocProvider.of<NewsBloc>(context).add(FetchNews(page: state.currentPage + 1));
//                         }
//                         return false;
//                       },
//                       child: ListView.builder(
//                         controller: _pageController,
//                         itemCount: (state.articles.length / itemsPerPage).ceil(),
//                         itemBuilder: (context, pageIndex) {
//                           final start = pageIndex * itemsPerPage;
//                           final end = min((pageIndex + 1) * itemsPerPage, state.articles.length);
//                           final pageArticles = state.articles.sublist(start, end);
//
//                           return Column(
//                             children: pageArticles.map((article) {
//                               return InkWell(
//                                 onTap: () {
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) => DetailsPage(article: article),
//                                     ),
//                                   );
//                                 },
//                                 child: Card(
//                                   elevation: 7,
//                                   margin: EdgeInsets.all(8.0),
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                                     children: [
//                                       ClipRRect(
//                                         borderRadius: BorderRadius.only(
//                                           topLeft: Radius.circular(8.0),
//                                           topRight: Radius.circular(8.0),
//                                         ),
//                                         child: Image.network(
//                                           article.urlToImage,
//                                           height: 150.0,
//                                           fit: BoxFit.cover,
//                                           errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
//                                             return Container(
//                                               color: Colors.white38,
//                                               height: 150.0,
//                                               child: Row(
//                                                 mainAxisAlignment: MainAxisAlignment.center,
//                                                 children: [
//                                                   Center(
//                                                     child: Icon(
//                                                       Icons.error,
//                                                       color: Colors.red,
//                                                     ),
//                                                   ),
//                                                   Center(
//                                                     child: Text('No image'),
//                                                   )
//                                                 ],
//                                               ),
//                                             );
//                                           },
//                                         ),
//                                       ),
//                                       Padding(
//                                         padding: EdgeInsets.all(12.0),
//                                         child: Text(
//                                           article.title,
//                                           style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
//                                         ),
//                                       ),
//                                       Row(
//                                         mainAxisAlignment: MainAxisAlignment.start,
//                                         mainAxisSize: MainAxisSize.min,
//                                         children: [
//                                           TextButton(
//                                             onPressed: () {
//                                               // Add your 'More' button logic here
//                                             },
//                                             child: Row(
//                                               children: [
//                                                 Text(
//                                                   'More',
//                                                   style: TextStyle(
//                                                     fontSize: 16,
//                                                     fontWeight: FontWeight.w500,
//                                                   ),
//                                                 ),
//                                                 Icon(Icons.chevron_right),
//                                               ],
//                                             ),
//                                           ),
//                                         ],
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               );
//                             }).toList(),
//                           );
//                         },
//                       ),
//                     ),
//                   ),
//                   Container(
//                     decoration: BoxDecoration(
//                       border: Border.all(
//                         color: Colors.grey,
//                         width: 1.0,
//                       ),
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                     margin: EdgeInsets.all(8.0),
//                     padding: EdgeInsets.all(8.0),
//                     child: SmoothPageIndicator(
//                       controller: _pageController,
//                       count: (state.articles.length / itemsPerPage).ceil(),
//                       effect: ExpandingDotsEffect(
//                         activeDotColor: Colors.black,
//                         dotColor: Colors.grey,
//                         dotHeight: 8.0,
//                         dotWidth: 8.0,
//                         spacing: 4.0,
//                       ),
//                     ),
//                   ),
//                 ],
//               );
//             } else if (state is NewsError) {
//               return Center(
//                 child: Text(
//                   state.errorMessage,
//                   style: TextStyle(color: Colors.red),
//                 ),
//               );
//             }
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
//
///
// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';
//
// class HomePage extends StatelessWidget {
//   final PageController _pageController = PageController();
//   final int itemsPerPage = 3;
//   bool isDataLoaded = false; // Flag to track whether data is already loaded
// bool isLoading = true;
//   @override
//   Widget build(BuildContext context) {
//     final _currentPage = ValueNotifier<double>(0);
//
//     return BlocProvider(
//       create: (context) => NewsBloc(newsRepository: NewsRepository()),
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text(
//             'News',
//             style: TextStyle(fontWeight: FontWeight.bold),
//           ),
//           centerTitle: true,
//           backgroundColor: Colors.white38,
//           elevation: 0,
//           leading: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Image.asset(
//               'images/21601.png',
//               height: 24.0,
//               width: 24.0,
//             ),
//           ),
//           actions: [
//             IconButton(
//               icon: Icon(Icons.refresh),
//               onPressed: () {
//                 BlocProvider.of<NewsBloc>(context).add(FetchNews());
//               },
//             ),
//           ],
//         ),
//         body: BlocBuilder<NewsBloc, NewsState>(
//           builder: (context, state) {
//             if (!isDataLoaded) {
//               BlocProvider.of<NewsBloc>(context).add(FetchNews());
//               isDataLoaded = true;
//             }
//
//             if (state is NewsLoaded) {
//               return Column(
//                 children: [
//                   Expanded(
//                     child: NotificationListener<ScrollNotification>(
//                       onNotification: (ScrollNotification scrollInfo) {
//                         if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
//                           BlocProvider.of<NewsBloc>(context).add(FetchNews(page: state.currentPage + 1));
//                         }
//                         return false;
//                       },
//                       child: ListView.builder(
//                         controller: _pageController,
//                         itemCount: (state.articles.length / itemsPerPage).ceil(),
//                         itemBuilder: (context, pageIndex) {
//                           final start = pageIndex * itemsPerPage;
//                           final end = min((pageIndex + 1) * itemsPerPage, state.articles.length);
//                           final pageArticles = state.articles.sublist(start, end);
//
//                           return Column(
//                             children: pageArticles.map((article) {
//                               return InkWell(
//                                 onTap: () {
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) => DetailsPage(article: article),
//                                     ),
//                                   );
//                                 },
//                                 child: Card(
//                                   elevation: 7,
//                                   margin: EdgeInsets.all(8.0),
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                                     children: [
//                                       ClipRRect(
//                                         borderRadius: BorderRadius.only(
//                                           topLeft: Radius.circular(8.0),
//                                           topRight: Radius.circular(8.0),
//                                         ),
//                                         child: Image.network(
//                                           article.urlToImage,
//                                           height: 150.0,
//                                           fit: BoxFit.cover,
//                                           errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
//                                             return Container(
//                                               color: Colors.white38,
//                                               height: 150.0,
//                                               child: Row(
//                                                 mainAxisAlignment: MainAxisAlignment.center,
//                                                 children: [
//                                                   Center(
//                                                     child: Icon(
//                                                       Icons.error,
//                                                       color: Colors.red,
//                                                     ),
//                                                   ),
//                                                   Center(
//                                                     child: Text('No image'),
//                                                   )
//                                                 ],
//                                               ),
//                                             );
//                                           },
//                                         ),
//                                       ),
//                                       Padding(
//                                         padding: EdgeInsets.all(12.0),
//                                         child: Text(
//                                           article.title,
//                                           style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
//                                         ),
//                                       ),
//                                       Row(
//                                         mainAxisAlignment: MainAxisAlignment.start,
//                                         mainAxisSize: MainAxisSize.min,
//                                         children: [
//                                           TextButton(
//                                             onPressed: () {
//                                               // Add your 'More' button logic here
//                                             },
//                                             child: Row(
//                                               children: [
//                                                 Text(
//                                                   'More',
//                                                   style: TextStyle(
//                                                     fontSize: 16,
//                                                     fontWeight: FontWeight.w500,
//                                                   ),
//                                                 ),
//                                                 Icon(Icons.chevron_right),
//                                               ],
//                                             ),
//                                           ),
//                                         ],
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               );
//                             }).toList(),
//                           );
//                         },
//                       ),
//
//                     ),
//                   ),
//                   Container(
//                     decoration: BoxDecoration(
//                       border: Border.all(
//                         color: Colors.grey,
//                         width: 1.0,
//                       ),
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                     margin: EdgeInsets.all(8.0),
//                     padding: EdgeInsets.all(8.0),
//                     child: SmoothPageIndicator(
//                       controller: _pageController,
//                       count: (state.articles.length / itemsPerPage).ceil(),
//                       effect: ExpandingDotsEffect(
//                         activeDotColor: Colors.black,
//                         dotColor: Colors.grey,
//                         dotHeight: 8.0,
//                         dotWidth: 8.0,
//                         spacing: 4.0,
//                       ),
//                     ),
//                   ),
//                 ],
//               );
//             } else if (state is NewsError) {
//               return Center(
//                 child: Text(
//                   state.errorMessage,
//                   style: TextStyle(color: Colors.red),
//                 ),
//               );
//             }
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

// class HomePage extends StatelessWidget {
//   final PageController _pageController = PageController();
//   final int itemsPerPage = 3;
//   bool isDataLoaded = false; // Flag to track whether data is already loaded
//   bool isLoading = true;
//
//   @override
//   Widget build(BuildContext context) {
//     final _currentPage = ValueNotifier<double>(0);
//
//     return BlocProvider(
//       create: (context) => NewsBloc(newsRepository: NewsRepository()),
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text(
//             'News',
//             style: TextStyle(fontWeight: FontWeight.bold),
//           ),
//           centerTitle: true,
//           backgroundColor: Colors.white38,
//           elevation: 0,
//           leading: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Image.asset(
//               'images/21601.png',
//               height: 24.0,
//               width: 24.0,
//             ),
//           ),
//           actions: [
//             IconButton(
//               icon: Icon(Icons.refresh),
//               onPressed: () {
//                 BlocProvider.of<NewsBloc>(context).add(FetchNews());
//               },
//             ),
//           ],
//         ),
//         body: BlocBuilder<NewsBloc, NewsState>(
//           builder: (context, state) {
//             if (!isDataLoaded) {
//               BlocProvider.of<NewsBloc>(context).add(FetchNews());
//               isDataLoaded = true;
//             }
//
//             return RefreshIndicator(
//               onRefresh: () async {
//                 BlocProvider.of<NewsBloc>(context).add(FetchNews());
//               },
//               child: state is NewsLoaded
//                   ? Column(
//                 children: [
//                   Expanded(
//                     child: NotificationListener<ScrollNotification>(
//                       onNotification: (ScrollNotification scrollInfo) {
//                         if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
//                           BlocProvider.of<NewsBloc>(context).add(FetchNews(page: state.currentPage + 1));
//                         }
//                         return false;
//                       },
//                       child: ListView.builder(
//                         controller: _pageController,
//                         itemCount: (state.articles.length / itemsPerPage).ceil(),
//                         itemBuilder: (context, pageIndex) {
//                           final start = pageIndex * itemsPerPage;
//                           final end = min((pageIndex + 1) * itemsPerPage, state.articles.length);
//                           final pageArticles = state.articles.sublist(start, end);
//
//                           return Column(
//                             children: pageArticles.map((article) {
//                               return InkWell(
//                                 onTap: () {
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) => DetailsPage(article: article),
//                                     ),
//                                   );
//                                 },
//                                 child: Card(
//                                   elevation: 7,
//                                   margin: EdgeInsets.all(8.0),
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                                     children: [
//                                       ClipRRect(
//                                         borderRadius: BorderRadius.only(
//                                           topLeft: Radius.circular(8.0),
//                                           topRight: Radius.circular(8.0),
//                                         ),
//                                         child: Image.network(
//                                           article.urlToImage,
//                                           height: 150.0,
//                                           fit: BoxFit.cover,
//                                           errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
//                                             return Container(
//                                               color: Colors.white38,
//                                               height: 150.0,
//                                               child: Row(
//                                                 mainAxisAlignment: MainAxisAlignment.center,
//                                                 children: [
//                                                   Center(
//                                                     child: Icon(
//                                                       Icons.error,
//                                                       color: Colors.red,
//                                                     ),
//                                                   ),
//                                                   Center(
//                                                     child: Text('No image'),
//                                                   )
//                                                 ],
//                                               ),
//                                             );
//                                           },
//                                         ),
//                                       ),
//                                       Padding(
//                                         padding: EdgeInsets.all(12.0),
//                                         child: Text(
//                                           article.title,
//                                           style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
//                                         ),
//                                       ),
//                                       Row(
//                                         mainAxisAlignment: MainAxisAlignment.start,
//                                         mainAxisSize: MainAxisSize.min,
//                                         children: [
//                                           TextButton(
//                                             onPressed: () {
//                                               // Add your 'More' button logic here
//                                             },
//                                             child: Row(
//                                               children: [
//                                                 Text(
//                                                   'More',
//                                                   style: TextStyle(
//                                                     fontSize: 16,
//                                                     fontWeight: FontWeight.w500,
//                                                   ),
//                                                 ),
//                                                 Icon(Icons.chevron_right),
//                                               ],
//                                             ),
//                                           ),
//                                         ],
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               );
//                             }).toList(),
//                           );
//                         },
//                       ),
//                     ),
//                   ),
//                   Container(
//                     decoration: BoxDecoration(
//                       border: Border.all(
//                         color: Colors.grey,
//                         width: 1.0,
//                       ),
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                     margin: EdgeInsets.all(8.0),
//                     padding: EdgeInsets.all(8.0),
//                     child: SmoothPageIndicator(
//                       controller: _pageController,
//                       count: (state.articles.length / itemsPerPage).ceil(),
//                       effect: ExpandingDotsEffect(
//                         activeDotColor: Colors.black,
//                         dotColor: Colors.grey,
//                         dotHeight: 8.0,
//                         dotWidth: 8.0,
//                         spacing: 4.0,
//                       ),
//                     ),
//                   ),
//                 ],
//               )
//                   : state is NewsError
//                   ? Center(
//                 child: Text(
//                   (state as NewsError).errorMessage,
//                   style: TextStyle(color: Colors.red),
//                 ),
//               )
//                   : Center(
//                 child: CircularProgressIndicator(),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
///

// class HomePage extends StatelessWidget {
//   final PageController _pageController = PageController();
//   final int itemsPerPage = 3;
//   bool isDataLoaded = false;
//
//   @override
//   Widget build(BuildContext context) {
//     final _currentPage = ValueNotifier<double>(0);
//
//     return BlocProvider(
//       create: (context) => NewsBloc(newsRepository: NewsRepository()),
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text(
//             'News',
//             style: TextStyle(fontWeight: FontWeight.bold),
//           ),
//           centerTitle: true,
//           backgroundColor: Colors.white38,
//           elevation: 0,
//           leading: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Image.asset(
//               'images/21601.png',
//               height: 24.0,
//               width: 24.0,
//             ),
//           ),
//           actions: [
//             IconButton(
//               icon: Icon(Icons.refresh),
//               onPressed: () {
//                 BlocProvider.of<NewsBloc>(context).add(FetchNews());
//               },
//             ),
//           ],
//         ),
//         body: BlocBuilder<NewsBloc, NewsState>(
//           builder: (context, state) {
//             if (!isDataLoaded) {
//               BlocProvider.of<NewsBloc>(context).add(FetchNews());
//               isDataLoaded = true;
//             }
//
//             return RefreshIndicator(
//               onRefresh: () async {
//                 BlocProvider.of<NewsBloc>(context).add(FetchNews());
//               },
//               child: state is NewsLoaded
//                   ? Column(
//                 children: [
//                   Expanded(
//                     child: NotificationListener<ScrollNotification>(
//                       onNotification: (ScrollNotification scrollInfo) {
//                         if (scrollInfo.metrics.pixels ==
//                             scrollInfo.metrics.maxScrollExtent) {
//                           BlocProvider.of<NewsBloc>(context).add(
//                               FetchNews(page: state.currentPage + 1));
//                         }
//                         return false;
//                       },
//                       child: ListView.builder(
//                         controller: _pageController,
//                         itemCount: (state.articles.length / itemsPerPage)
//                             .ceil(),
//                         itemBuilder: (context, pageIndex) {
//                           final start = pageIndex * itemsPerPage;
//                           final end = min(
//                               (pageIndex + 1) * itemsPerPage,
//                               state.articles.length);
//                           final pageArticles =
//                           state.articles.sublist(start, end);
//
//                           return Column(
//                             children: pageArticles.map((article) {
//                               return InkWell(
//                                 onTap: () {
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) =>
//                                           DetailsPage(article: article),
//                                     ),
//                                   );
//                                 },
//
//                                 child: Card(
//                                   elevation: 7,
//                                   margin: EdgeInsets.all(8.0),
//                                   child: Container(
//                                     width: double.infinity, // Add explicit width to FutureBuilder
//                                     height: 280, // Add explicit height to FutureBuilder
//                                     child: FutureBuilder(
//                                       future: Future.delayed(Duration(seconds: 2), () => article),
//                                       builder: (context, snapshot) {
//                                         if (snapshot.connectionState == ConnectionState.waiting) {
//                                           return AppShimmerLoader(
//                                             width: double.infinity,
//                                             height: 150.0 + 12.0 + 16.0,
//                                             shimmerDuration: Duration(seconds: 3), // Adjust the duration if needed
//                                           );
//                                         } else if (snapshot.hasError) {
//                                           return Text('Error: ${snapshot.error}');
//                                         } else {
//                                           return YourCardWidget(
//                                             article: snapshot.data,
//                                             onMorePressed: () {
//                                               // Handle 'More' button press
//                                             },
//                                           );
//                                         }
//                                       },
//                                     )
//
//                                   ),
//                                 ),
//
//                               );
//                             }).toList(),
//                           );
//                         },
//                       ),
//                     ),
//                   ),
//                   // ... (your existing Container and SmoothPageIndicator code)
//                 ],
//               )
//                   : state is NewsError
//                   ? Center(
//                 child: Text(
//                   (state as NewsError).errorMessage,
//                   style: TextStyle(color: Colors.red),
//                 ),
//               )
//                   : Center(
//                 child: CircularProgressIndicator(),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
//
// }
class HomePage extends StatelessWidget {
  final PageController _pageController = PageController();
  final int itemsPerPage = 3;
  bool isDataLoaded = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsBloc(newsRepository: NewsRepository()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'News',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.white38,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'images/21601.png',
              height: 24.0,
              width: 24.0,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                BlocProvider.of<NewsBloc>(context).add(FetchNews());
              },
            ),
          ],
        ),
        body: BlocBuilder<NewsBloc, NewsState>(
          builder: (context, state) {
            if (!isDataLoaded) {
              BlocProvider.of<NewsBloc>(context).add(FetchNews());
              isDataLoaded = true;
            }

            return RefreshIndicator(
              onRefresh: () async {
                BlocProvider.of<NewsBloc>(context).add(FetchNews());
              },
              child: state is NewsLoaded
                  ? Column(
                children: [
                  Expanded(
                    child: NotificationListener<ScrollNotification>(
                      onNotification: (ScrollNotification scrollInfo) {
                        if (scrollInfo.metrics.pixels ==
                            scrollInfo.metrics.maxScrollExtent) {
                          BlocProvider.of<NewsBloc>(context).add(
                              FetchNews(page: state.currentPage + 1));
                        }
                        return false;
                      },
                      child: ListView.builder(
                        controller: _pageController,
                        itemCount:
                        (state.articles.length / itemsPerPage).ceil(),
                        itemBuilder: (context, pageIndex) {
                          final start = pageIndex * itemsPerPage;
                          final end = min(
                              (pageIndex + 1) * itemsPerPage,
                              state.articles.length);
                          final pageArticles =
                          state.articles.sublist(start, end);

                          return Column(
                            children: pageArticles.map((article) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          DetailsPage(article: article),
                                    ),
                                  );
                                },
                                child: Card(
                                  elevation: 7,
                                  margin: EdgeInsets.all(8.0),
                                  child: FutureBuilder(
                                    future: Future.delayed(
                                      Duration(seconds: 2),
                                          () => article,
                                    ),
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        return AppShimmerLoader(
                                          width: double.infinity,
                                          height: 150.0 + 12.0 + 16.0,
                                          shimmerDuration:
                                          Duration(seconds: 3),
                                        );
                                      } else if (snapshot.hasError) {
                                        return Text(
                                            'Error: ${snapshot.error}');
                                      } else {
                                        return YourCardWidget(
                                          article: snapshot.data,
                                          onMorePressed: () {
                                            // Handle 'More' button press
                                          },
                                        );
                                      }
                                    },
                                  ),
                                ),
                              );
                            }).toList(),
                          );
                        },
                      ),
                    ),
                  ),
                  // ... (your existing Container and SmoothPageIndicator code)
                ],
              )
                  : state is NewsError
                  ? Center(
                child: Text(
                  (state as NewsError).errorMessage,
                  style: TextStyle(color: Colors.red),
                ),
              )
                  : Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        ),
      ),
    );
  }
}

class YourCardWidget extends StatelessWidget {
  final ArticleModel? article;
  final VoidCallback onMorePressed;

  YourCardWidget({required this.article, required this.onMorePressed});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 7,
      margin: EdgeInsets.all(7.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (article?.urlToImage != null)
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.0),
                topRight: Radius.circular(8.0),
              ),
              child: Image.network(
                article!.urlToImage!,
                height: 150.0,
                fit: BoxFit.cover,
                errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                  return Container(
                    color: Colors.white38,
                    height: 150.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Image.asset(
                            'images/no-image-icon-23494.png',
                          ),
                        ),
                        Center(
                          child: Text('No image'),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              article?.title ?? 'No title available',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ),
          // Add your additional content here
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                onPressed: onMorePressed,
                child: Row(
                  children: [
                    Text(
                      'More',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Icon(Icons.chevron_right),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
