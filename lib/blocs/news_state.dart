

import 'package:equatable/equatable.dart';

import '../model/article_model.dart';

abstract class NewsState extends Equatable {
  const NewsState();

  @override
  List<Object> get props => [];
}

class NewsInitial extends NewsState {}

class NewsLoaded extends NewsState {
  final List<ArticleModel> articles;

  NewsLoaded({required this.articles});

  @override
  List<Object> get props => [articles];
}

class NewsError extends NewsState {
  final String errorMessage;

  NewsError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
