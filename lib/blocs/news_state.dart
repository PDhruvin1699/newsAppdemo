

import 'package:equatable/equatable.dart';

import '../model/article_model.dart';
//
// abstract class NewsState extends Equatable {
//   const NewsState();
//
//   @override
//   List<Object> get props => [];
// }
//
// class NewsInitial extends NewsState {}
// //
// // class NewsLoaded extends NewsState {
// //   final List<ArticleModel> articles;
// //
// //   NewsLoaded({required this.articles});
// //
// //   @override
// //   List<Object> get props => [articles];
// // }
// class NewsLoaded extends NewsState {
//   final List<ArticleModel> articles;
//   final int currentPage;
//
//   NewsLoaded({required this.articles, required this.currentPage});
//
//   @override
//   List<Object> get props => [articles, currentPage];
// }
// class NewsError extends NewsState {
//   final String errorMessage;
//
//   NewsError({required this.errorMessage});
//
//   @override
//   List<Object> get props => [errorMessage];
// }
abstract class NewsState extends Equatable {
  const NewsState();
}

class NewsInitial extends NewsState {
  @override
  List<Object> get props => [];
}

// Add this state to your NewsBloc states

abstract class LoadedNewsState extends NewsState {
  final List<ArticleModel> articles;
  final int currentPage;

  const LoadedNewsState({required this.articles, required this.currentPage});

  @override
  List<Object> get props => [articles, currentPage];
}

class NewsLoaded extends LoadedNewsState {
  NewsLoaded({required List<ArticleModel> articles, required int currentPage})
      : super(articles: articles, currentPage: currentPage);
}
class NewsLoading extends NewsState {
  const NewsLoading();

  @override
  List<Object> get props => [];
}
class NewsError extends NewsState {
  final String errorMessage;

  NewsError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
