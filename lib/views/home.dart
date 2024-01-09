import 'dart:io';

import 'dart:math';

import 'package:blocnewsdemo/contacts/news_repository.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blocnewsdemo/blocs/news_bloc.dart';
import 'package:blocnewsdemo/blocs/news_event.dart';
import 'package:blocnewsdemo/blocs/news_state.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../blocs/thembloc.dart';
import '../blocs/themeevent.dart';
import '../model/article_model.dart';
import '../utiles/naviagtionbar.dart';
import '../utiles/shiimer.dart';
import 'card.dart';
import 'details.dart';

///

///
// class HomePage extends StatelessWidget {
//   final PageController _pageController = PageController();
//   final int itemsPerPage = 3;
//   bool isDataLoaded = false;
//
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
//                         itemCount:
//                         (state.articles.length / itemsPerPage).ceil(),
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
//                                 child: Card(
//                                   elevation: 7,
//                                   margin: EdgeInsets.all(8.0),
//                                   child: FutureBuilder(
//                                     future: Future.delayed(
//                                       Duration(seconds: 2),
//                                           () => article,
//                                     ),
//                                     builder: (context, snapshot) {
//                                       if (!snapshot.hasData) {
//                                         return AppShimmerLoader(
//                                           width: double.infinity,
//                                           height: 150.0 + 12.0 + 16.0,
//                                           shimmerDuration:
//                                           Duration(seconds: 3),
//                                         );
//                                       } else if (snapshot.hasError) {
//                                         return Text(
//                                             'Error: ${snapshot.error}');
//                                       } else {
//                                         return YourCardWidget(
//                                           article: snapshot.data,
//                                           onMorePressed: () {
//                                             // Handle 'More' button press
//                                           },
//                                         );
//                                       }
//                                     },
//                                   ),
//                                 ),
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
// }
//
///
// class YourCardWidget extends StatelessWidget {
//   final ArticleModel? article;
//   final VoidCallback onMorePressed;
//
//   YourCardWidget({required this.article, required this.onMorePressed});
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 7,
//       margin: EdgeInsets.all(7.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           if (article?.urlToImage != null)
//             FutureBuilder(
//               future: _isOnline(),
//               builder: (context, snapshot) {
//                 if (snapshot.hasData && snapshot.data == true) {
//                   // Online, display online image
//                   return ClipRRect(
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(8.0),
//                       topRight: Radius.circular(8.0),
//                     ),
//                     child: Image.network(
//                       article!.urlToImage!,
//                       height: 150.0,
//                       fit: BoxFit.cover,
//                       errorBuilder:
//                           (BuildContext context, Object error, StackTrace? stackTrace) {
//                         return Container(
//                           color: Colors.white38,
//                           height: 150.0,
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Center(
//                                 child: Image.asset(
//                                   'images/no-image-icon-23494.png',
//                                 ),
//                               ),
//                               Center(
//                                 child: Text('No image'),
//                               ),
//                             ],
//                           ),
//                         );
//                       },
//                     ),
//                   );
//                 } else {
//                   // Offline, display offline image
//                   return ClipRRect(
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(8.0),
//                       topRight: Radius.circular(8.0),
//                     ),
//                     child: Image.asset(
//                       'images/no-image-icon-23494.png',
//                       height: 150.0,
//                       fit: BoxFit.cover,
//                     ),
//                   );
//                 }
//               },
//             ),
//           Padding(
//             padding: EdgeInsets.all(8.0),
//             child: Text(
//               article?.title ?? 'No title available',
//               style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
//             ),
//           ),
//           // Add your additional content here
//           Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextButton(
//                 onPressed: onMorePressed,
//                 child: Row(
//                   children: [
//                     Text(
//                       'More',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     Icon(Icons.chevron_right),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   Future<bool> _isOnline() async {
//     var connectivityResult = await Connectivity().checkConnectivity();
//     return connectivityResult != ConnectivityResult.none;
//   }
// }
/// liked  button
// class YourCardWidget extends StatelessWidget {
//   final ArticleModel? article;
//   final VoidCallback onMorePressed;
//   final Function(BuildContext, ArticleModel) onLikePressed;
//
//   YourCardWidget({
//     required this.article,
//     required this.onMorePressed,
//     required this.onLikePressed,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 7,
//       margin: EdgeInsets.all(7.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           if (article?.urlToImage != null)
//             FutureBuilder<bool>(
//               future: _isOnline(),
//               builder: (context, snapshot) {
//                 if (snapshot.hasData && snapshot.data == true) {
//                   return ClipRRect(
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(8.0),
//                       topRight: Radius.circular(8.0),
//                     ),
//                     child: Image.network(
//                       article!.urlToImage!,
//                       height: 150.0,
//                       fit: BoxFit.cover,
//                       errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
//                         return Container(
//                           color: Colors.white38,
//                           height: 150.0,
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Center(
//                                 child: Image.asset(
//                                   'images/no-image-icon-23494.png',
//                                 ),
//                               ),
//                               Center(
//                                 child: Text('No image'),
//                               ),
//                             ],
//                           ),
//                         );
//                       },
//                     ),
//                   );
//                 } else {
//                   return FutureBuilder<String>(
//                     future: _getOfflineImagePath(article!.urlToImage!),
//                     builder: (context, snapshot) {
//                       if (snapshot.connectionState == ConnectionState.done) {
//                         final String offlineImagePath = snapshot.data!;
//                         return ClipRRect(
//                           borderRadius: BorderRadius.only(
//                             topLeft: Radius.circular(8.0),
//                             topRight: Radius.circular(8.0),
//                           ),
//                           child: Image.file(
//                             File(offlineImagePath),
//                             height: 150.0,
//                             fit: BoxFit.cover,
//                           ),
//                         );
//                       } else {
//                         return Container();
//                       }
//                     },
//                   );
//                 }
//               },
//             ),
//           Padding(
//             padding: EdgeInsets.all(8.0),
//             child: Text(
//               article?.title ?? 'No title available',
//               style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
//             ),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextButton(
//                 onPressed: onMorePressed,
//                 child: Row(
//                   children: [
//                     Text(
//                       'More',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     Icon(Icons.chevron_right),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           Align(
//             alignment: Alignment.topRight,
//             child: IconButton(
//               icon: Icon(
//                 article?.isLiked == true ? Icons.favorite : Icons.favorite_border,
//                 color: Colors.red,
//               ),
//               onPressed: () {
//                 onLikePressed(context, article!);
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Future<bool> _isOnline() async {
//     var connectivityResult = await Connectivity().checkConnectivity();
//     return connectivityResult != ConnectivityResult.none;
//   }
//
//   Future<String> _getOfflineImagePath(String onlineImagePath) async {
//     final Directory appDocDir = await getApplicationDocumentsDirectory();
//     final String fileName = onlineImagePath.split('/').last;
//     return '${appDocDir.path}/images/$fileName';
//   }
// }
//
// class HomePage extends StatelessWidget {
//   final PageController _pageController = PageController();
//   final int itemsPerPage = 3;
//   bool isDataLoaded = false;
//   List<ArticleModel> likedArticles = [];
//   List<ArticleModel> trendingLikedArticles = [];
//   List<ArticleModel> forYouLikedArticles = [];
//   List<ArticleModel> likedTabArticles = [];
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => NewsBloc(newsRepository: NewsRepository()),
//       child: DefaultTabController(
//         length: 3,
//         child: Scaffold(
//           appBar: AppBar(
//             title: Text(
//               'News',
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             centerTitle: true,
//             backgroundColor: Colors.white38,
//             elevation: 0,
//             leading: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Image.asset(
//                 'images/21601.png',
//                 height: 24.0,
//                 width: 24.0,
//               ),
//             ),
//             actions: [
//               IconButton(
//                 icon: Icon(Icons.refresh),
//                 onPressed: () {
//                   BlocProvider.of<NewsBloc>(context).add(FetchNews());
//                 },
//               ),
//             ],
//             bottom: TabBar(
//               tabs: [
//                 Tab(text: 'Trending'),
//                 Tab(text: 'For You'),
//                 Tab(text: 'Liked'),
//               ],
//             ),
//           ),
//           body: BlocBuilder<NewsBloc, NewsState>(
//             builder: (context, state) {
//               if (!isDataLoaded) {
//                 BlocProvider.of<NewsBloc>(context).add(FetchNews());
//                 isDataLoaded = true;
//               }
//
//               return RefreshIndicator(
//                 onRefresh: () async {
//                   BlocProvider.of<NewsBloc>(context).add(FetchNews());
//                 },
//                 child: state is NewsLoaded
//                     ? TabBarView(
//                   children: [
//                     buildTabContent(context, state, 'Trending'),
//                     buildTabContent(context, state, 'For You'),
//                     buildLikedTabContent(context),
//                   ],
//                 )
//                     : state is NewsError
//                     ? Center(
//                   child: Text(
//                     (state as NewsError).errorMessage,
//                     style: TextStyle(color: Colors.red),
//                   ),
//                 )
//                     : Center(
//                   child: CircularProgressIndicator(),
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget buildTabContent(
//       BuildContext context,
//       NewsLoaded state,
//       String tabTitle,
//       ) {
//     return Column(
//       children: [
//         Expanded(
//           child: NotificationListener<ScrollNotification>(
//             onNotification: (ScrollNotification scrollInfo) {
//               if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
//                 BlocProvider.of<NewsBloc>(context).add(
//                   FetchNews(page: state.currentPage + 1),
//                 );
//               }
//               return false;
//             },
//             child: ListView.builder(
//               controller: _pageController,
//               itemCount: (state.articles.length / itemsPerPage).ceil(),
//               itemBuilder: (context, pageIndex) {
//                 final start = pageIndex * itemsPerPage;
//                 final end = min(
//                   (pageIndex + 1) * itemsPerPage,
//                   state.articles.length,
//                 );
//                 final pageArticles = state.articles.sublist(start, end);
//
//                 return Column(
//                   children: pageArticles.map((article) {
//                     return InkWell(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => DetailsPage(article: article),
//                           ),
//                         );
//                       },
//                       child: Card(
//                         elevation: 7,
//                         margin: EdgeInsets.all(8.0),
//                         child: FutureBuilder(
//                           future: Future.delayed(
//                             Duration(seconds: 2),
//                                 () => article,
//                           ),
//                           builder: (context, snapshot) {
//                             if (!snapshot.hasData) {
//                               return AppShimmerLoader(
//                                 width: double.infinity,
//                                 height: 150.0 + 12.0 + 16.0,
//                                 shimmerDuration: Duration(seconds: 3),
//                               );
//                             } else if (snapshot.hasError) {
//                               return Text('Error: ${snapshot.error}');
//                             } else {
//                               return YourCardWidget(
//                                 article: snapshot.data,
//                                 onMorePressed: () {
//                                   // Handle 'More' button press
//                                 },
//                                 onLikePressed: (context, likedArticle) {
//                                   handleLikePressed(context, likedArticle, tabTitle);
//                                 },
//                               );
//                             }
//                           },
//                         ),
//                       ),
//                     );
//                   }).toList(),
//                 );
//               },
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget buildLikedTabContent(BuildContext context) {
//     final likedTabArticles = likedArticles;
//
//     return ListView.builder(
//       itemCount: likedTabArticles.length,
//       itemBuilder: (context, index) {
//         final likedArticle = likedTabArticles[index];
//
//         return InkWell(
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => DetailsPage(article: likedArticle),
//               ),
//             );
//           },
//           child: Card(
//             elevation: 7,
//             margin: EdgeInsets.all(8.0),
//             child: YourCardWidget(
//               article: likedArticle,
//               onMorePressed: () {
//                 // Handle 'More' button press
//               },
//               onLikePressed: (context, article) {
//                 handleLikePressed(context, article, 'Liked');
//               },
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   void handleLikePressed(BuildContext context, ArticleModel likedArticle, String currentTab) {
//     if (likedArticle.isLiked == true) {
//       likedArticles.remove(likedArticle);
//     } else {
//       likedArticles.add(likedArticle);
//     }
//
//     likedArticle.isLiked = !likedArticle.isLiked;
//
//     if (currentTab == 'Liked') {
//       BlocProvider.of<NewsBloc>(context).add(FetchLikedNews(likedArticles, isLikedPage: true));
//     } else {
//       BlocProvider.of<NewsBloc>(context).add(FetchLikedNews(likedArticles, isLikedPage: false));
//     }
//   }
// }

/// finish
// WOrking Code

// class YourCardWidget extends StatelessWidget {
//   final ArticleModel? article;
//   final VoidCallback onMorePressed;
//   final VoidCallback onLikePressed; // New callback for like button
//
//   YourCardWidget({
//     required this.article,
//     required this.onMorePressed,
//     required this.onLikePressed,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 7,
//       margin: EdgeInsets.all(7.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           if (article?.urlToImage != null)
//             FutureBuilder<bool>(
//               future: _isOnline(),
//               builder: (context, snapshot) {
//                 if (snapshot.hasData && snapshot.data == true) {
//                   return Stack(
//                     children: [
//                       ClipRRect(
//                         borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(8.0),
//                           topRight: Radius.circular(8.0),
//                         ),
//                         child: Image.network(
//                           article!.urlToImage!,
//                           height: 150.0,
//                           fit: BoxFit.cover,
//                           errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
//                             return Container(
//                               color: Colors.white38,
//                               height: 150.0,
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Center(
//                                     child: Image.asset(
//                                       'images/no-image-icon-23494.png',
//                                     ),
//                                   ),
//                                   Center(
//                                     child: Text('No image'),
//                                   ),
//                                 ],
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                       Positioned(
//                         top: 8.0,
//                         right: 8.0,
//                         child: IconButton(
//                           icon: Icon(Icons.favorite),
//                           color: Colors.red, // Customize the color as needed
//                           onPressed: onLikePressed,
//                         ),
//                       ),
//                     ],
//                   );
//                 } else {
//                   return FutureBuilder<String>(
//                     future: _getOfflineImagePath(article!.urlToImage!),
//                     builder: (context, snapshot) {
//                       if (snapshot.connectionState == ConnectionState.done) {
//                         final String offlineImagePath = snapshot.data!;
//                         return Stack(
//                           children: [
//                             ClipRRect(
//                               borderRadius: BorderRadius.only(
//                                 topLeft: Radius.circular(8.0),
//                                 topRight: Radius.circular(8.0),
//                               ),
//                               child: Image.file(
//                                 File(offlineImagePath),
//                                 height: 150.0,
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                             Positioned(
//                               top: 8.0,
//                               right: 8.0,
//                               child: IconButton(
//                                 icon: Icon(Icons.favorite),
//                                 color: Colors.red, // Customize the color as needed
//                                 onPressed: onLikePressed,
//                               ),
//                             ),
//                           ],
//                         );
//                       } else {
//                         // You can return a loading indicator here if needed
//                         return Container();
//                       }
//                     },
//                   );
//                 }
//               },
//             ),
//           Padding(
//             padding: EdgeInsets.all(8.0),
//             child: Text(
//               article?.title ?? 'No title available',
//               style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
//             ),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextButton(
//                 onPressed: onMorePressed,
//                 child: Row(
//                   children: [
//                     Text(
//                       'More',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     Icon(Icons.chevron_right),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Future<bool> _isOnline() async {
//     var connectivityResult = await Connectivity().checkConnectivity();
//     return connectivityResult != ConnectivityResult.none;
//   }
//
//   Future<String> _getOfflineImagePath(String onlineImagePath) async {
//     final Directory appDocDir = await getApplicationDocumentsDirectory();
//     final String fileName = onlineImagePath.split('/').last;
//     return '${appDocDir.path}/images/$fileName';
//   }
//
// }
import 'package:shimmer/shimmer.dart';




class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  static const routeName = '/home';
  final int itemsPerPage = 3;

  bool isDataLoaded = false;

  bool isSynced = false;
 // Add a flag for synchronization
  double textSize = 18.0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsBloc(newsRepository: NewsRepository()),
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'News',
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
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
                  icon: Icon(Icons.brightness_6),
                  onPressed: () {
                    BlocProvider.of<ThemeBloc>(context).add(ToggleTheme());
                  },
                ),

              IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () {
                  BlocProvider.of<NewsBloc>(context).add(FetchNews());
                  // Reset synchronization flag on refresh
                  isSynced = false;
                },
              ),

            ],
            bottom: TabBar(
              tabs: [
                Tab(text: 'Trending'),
                Tab(text: 'For You'),
                Tab(text: 'Liked'),
                PreferredSize(
                  preferredSize: Size.fromHeight(50.0),
                  child: Column(
                    children: [
                      Slider(
                        value: textSize,
                        min: 10.0,
                        max: 30.0,
                        onChanged: (value) {
                          setState(() {
                            textSize = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],

            ),
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
                  // Reset synchronization flag on pull-to-refresh
                  isSynced = false;
                },
                child: state is NewsLoaded
                    ? TabBarView(
                  children: [
                    buildTabContent(context, state, 'Trending'),
                    buildTabContent(context, state, 'For You'),
                    buildTabContent(context, state, 'Liked'),
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
      ),
    );
  }

  Widget buildTabContent(
      BuildContext context,
      NewsLoaded state,
      String tabTitle,
      ) {
    List<ArticleModel> tabArticles = [];

    if (tabTitle == 'Trending') {
      tabArticles = state.articles;
    }

    return Column(
      children: [
        Expanded(
          child: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
                // Check if synchronization has already occurred
                if (!isSynced) {
                  BlocProvider.of<NewsBloc>(context).add(
                    FetchNews(page: state.currentPage + 1),
                  );
                  // Set synchronization flag to true
                  isSynced = true;
                }
              }
              return false;
            },
            child: ListView.builder(
              controller: _pageController,
              itemCount: (tabArticles.length / itemsPerPage).ceil(),
              itemBuilder: (context, pageIndex) {
                final start = pageIndex * itemsPerPage;
                final end = min(
                  (pageIndex + 1) * itemsPerPage,
                  tabArticles.length,
                );
                final pageArticles = tabArticles.sublist(start, end);

                return Column(
                  children: pageArticles.map((article) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailsPage(article: article),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 7,
                        margin: EdgeInsets.all(8.0),
                        child: YourCardWidget(
                          article: article,
                          onMorePressed: () {
                            // Handle 'More' button press
                          },
                            textSize: textSize
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
//   Widget buildTabContent(
//       BuildContext context,
//       NewsLoaded state,
//       String tabTitle,
//       ) {
//     return Column(
//       children: [
//         Expanded(
//           child: NotificationListener<ScrollNotification>(
//             onNotification: (ScrollNotification scrollInfo) {
//               if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
//                 BlocProvider.of<NewsBloc>(context).add(
//                   FetchNews(page: state.currentPage + 1),
//                 );
//               }
//               return false;
//             },
//             child: ListView.builder(
//               controller: _pageController,
//               itemCount: (state.articles.length / itemsPerPage).ceil(),
//               itemBuilder: (context, pageIndex) {
//                 final start = pageIndex * itemsPerPage;
//                 final end = min(
//                   (pageIndex + 1) * itemsPerPage,
//                   state.articles.length,
//                 );
//                 final pageArticles = state.articles.sublist(start, end);
//
//                 return Column(
//                   children: pageArticles.map((article) {
//                     return InkWell(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => DetailsPage(article: article),
//                           ),
//                         );
//                       },
//                       child: Card(
//                         elevation: 7,
//                         margin: EdgeInsets.all(8.0),
//                         child: FutureBuilder(
//                           future: Future.delayed(
//                             Duration(seconds: 2),
//                                 () => article,
//                           ),
//                           builder: (context, snapshot) {
//                             if (!snapshot.hasData) {
//                               return AppShimmerLoader(
//                                 width: double.infinity,
//                                 height: 150.0 + 12.0 + 16.0,
//                                 shimmerDuration: Duration(seconds: 3),
//                               );
//                             } else if (snapshot.hasError) {
//                               return Text('Error: ${snapshot.error}');
//                             } else {
//                               return YourCardWidget(
//                                 article: snapshot.data,
//                                 onMorePressed: () {
//                                   // Handle 'More' button press
//                                 },
//                               );
//                             }
//                           },
//                         ),
//                       ),
//                     );
//                   }).toList(),
//                 );
//               },
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
/// finish  working coded
//
//
// class HomePage extends StatelessWidget {
//   final PageController _pageController = PageController();
//   final int itemsPerPage = 3;
//   bool isDataLoaded = false;
//
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
//     leading: Padding(
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
//           // ... existing code ...
//
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
//                             FetchNews(page: state.currentPage + 1),
//                           );
//                         }
//                         return false;
//                       },
//                       child: ListView.builder(
//                         controller: _pageController,
//                         itemCount:
//                         (state.articles.length / itemsPerPage).ceil(),
//                         itemBuilder: (context, pageIndex) {
//                           final start = pageIndex * itemsPerPage;
//                           final end = min(
//                             (pageIndex + 1) * itemsPerPage,
//                             state.articles.length,
//                           );
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
//                                 child: Card(
//                                   elevation: 7,
//                                   margin: EdgeInsets.all(8.0),
//                                   child: FutureBuilder(
//                                     future: Future.delayed(
//                                       Duration(seconds: 2),
//                                           () => article,
//                                     ),
//                                     builder: (context, snapshot) {
//                                       if (!snapshot.hasData) {
//                                         return AppShimmerLoader(
//                                           width: double.infinity,
//                                           height: 150.0 + 12.0 + 16.0,
//                                           shimmerDuration:
//                                           Duration(seconds: 3),
//                                         );
//                                       } else if (snapshot.hasError) {
//                                         return Text(
//                                             'Error: ${snapshot.error}');
//                                       } else {
//                                         return YourCardWidget(
//                                           article: snapshot.data,
//                                           onMorePressed: () {
//                                             // Handle 'More' button press
//                                           },
//                                         );
//                                       }
//                                     },
//                                   ),
//                                 ),
//                               );
//                             }).toList(),
//                           );
//                         },
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
// Import your NewsBloc and related classes
