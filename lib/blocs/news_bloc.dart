

import 'package:blocnewsdemo/blocs/news_event.dart';
import 'package:blocnewsdemo/blocs/news_event.dart';
import 'package:blocnewsdemo/blocs/news_state.dart';
import 'package:blocnewsdemo/model/article_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../contacts/news_repository.dart';

//
// class NewsBloc extends Bloc<NewsEvent, NewsState> {
//   final NewsRepository newsRepository;
//
//   NewsBloc({required this.newsRepository}) : super(NewsInitial());
//
//   @override
//   Stream<NewsState> mapEventToState(
//       NewsEvent event,
//       ) async* {
//     if (event is FetchNews) {
//       try {
//         final List<ArticleModel> articles = await newsRepository.getNews();
//         yield NewsLoaded(articles: articles);
//       } catch (e) {
//         yield NewsError(errorMessage: 'Failed to fetch news');
//       }
//     }
//   }
// }
import 'package:bloc/bloc.dart';
import 'package:blocnewsdemo/blocs/news_event.dart';
import 'package:blocnewsdemo/blocs/news_state.dart';


class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepository newsRepository;

  NewsBloc({required this.newsRepository}) : super(NewsInitial()) {
    // Register the event handler for FetchNews
    on<FetchNews>((event, emit) => _mapFetchNewsToState(emit));
  }

  Future<void> _mapFetchNewsToState(Emitter<NewsState> emit) async {
    try {
      final List<ArticleModel> articles = await newsRepository.getNews();
      emit(NewsLoaded(articles: articles));
    } catch (e) {
      emit(NewsError(errorMessage: 'Failed to fetch news. Error: $e'));
    }
  }
}