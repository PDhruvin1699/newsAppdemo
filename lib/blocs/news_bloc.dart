

import 'package:blocnewsdemo/blocs/news_event.dart';
import 'package:blocnewsdemo/blocs/news_event.dart';
import 'package:blocnewsdemo/blocs/news_state.dart';
import 'package:blocnewsdemo/model/article_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../contacts/news_repository.dart';

import 'package:bloc/bloc.dart';
import 'package:blocnewsdemo/blocs/news_event.dart';
import 'package:blocnewsdemo/blocs/news_state.dart';

//
// class NewsBloc extends Bloc<NewsEvent, NewsState> {
//   final NewsRepository newsRepository;
//
//   NewsBloc({required this.newsRepository}) : super(NewsInitial()) {
//     // Register the event handler for FetchNews
//     on<FetchNews>((event, emit) => _mapFetchNewsToState(emit));
//   }
//
//   Future<void> _mapFetchNewsToState(Emitter<NewsState> emit) async {
//     try {
//       final List<ArticleModel> articles = await newsRepository.getNews();
//       emit(NewsLoaded(articles: articles));
//     } catch (e) {
//       emit(NewsError(errorMessage: 'Failed to fetch news. Error: $e'));
//     }
//   }
// }

// class NewsBloc extends Bloc<NewsEvent, NewsState> {
//   final NewsRepository newsRepository;
//   final int itemsPerPage = 3; // Set your desired items per page
//
//   NewsBloc({required this.newsRepository}) : super(NewsInitial()) {
//     // Register the event handler for FetchNews
//     on<FetchNews>((event, emit) => _mapFetchNewsToState(event, emit));
//   }
//
//   // Future<void> _mapFetchNewsToState(FetchNews event, Emitter<NewsState> emit) async {
//   //   try {
//   //     final List<ArticleModel> articles = await newsRepository.getNews(page: event.page);
//   //     emit(NewsLoaded(articles: articles, currentPage: event.page));
//   //   } catch (e) {
//   //     emit(NewsError(errorMessage: 'Failed to fetch news. Error: $e'));
//   //   }
//   // }
//   Future<void> _mapFetchNewsToState(FetchNews event, Emitter<NewsState> emit) async {
//     try {
//       final List<ArticleModel> articles = await newsRepository.getNews(page: event.page);
//
//       if (event.page == 1) {
//         emit(NewsLoaded(articles: articles, currentPage: event.page));
//       } else if (state is LoadedNewsState) {
//         final List<ArticleModel> existingArticles = (state as LoadedNewsState).articles;
//
//         // Filter out articles that already exist
//         final List<ArticleModel> newArticles = articles.where((article) => !existingArticles.contains(article)).toList();
//
//         emit(NewsLoaded(
//           articles: [...existingArticles, ...newArticles],
//           currentPage: event.page,
//         ));
//       }
//     } catch (e) {
//       emit(NewsError(errorMessage: 'Failed to fetch news. Error: $e'));
//     }
//   }
//
// }
// ... (imports remain unchanged)
// ... (imports remain unchanged)

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepository newsRepository;
  final int itemsPerPage = 3;

  NewsBloc({required this.newsRepository}) : super(NewsInitial()) {
    on<FetchNews>(_mapFetchNewsToState);
  }

  Future<void> _mapFetchNewsToState(FetchNews event, Emitter<NewsState> emit) async {
    try {
      final List<ArticleModel> articles = await newsRepository.getNews(page: event.page);

      if (event.page == 1) {
        emit(NewsLoaded(articles: articles, currentPage: event.page));
      } else if (state is NewsLoaded) {
        final List<ArticleModel> existingArticles = (state as NewsLoaded).articles;

        // Identify and add only new articles to the existing list
        final List<ArticleModel> newArticles = articles
            .where((article) => !existingArticles.any((existingArticle) => existingArticle.title == article.title))
            .toList();

        if (newArticles.isNotEmpty) {
          emit(NewsLoaded(
            articles: [...existingArticles, ...newArticles],
            currentPage: event.page,
          ));
        }
      }
    } catch (e) {
      emit(NewsError(errorMessage: 'Failed to fetch news. Error: $e'));
    }
  }
}

// ... (rest of the code remains unchanged)

// ... (rest of the code remains unchanged)
