
import 'package:equatable/equatable.dart';

// abstract class NewsEvent extends Equatable {
//   const NewsEvent();
// }
//
// class FetchNews extends NewsEvent {
//   // Add this line to include the 'page' parameter
//
//   FetchNews(); // Update the constructor
//
//   @override
//   List<Object> get props => [];
// }
abstract class NewsEvent extends Equatable {
  const NewsEvent();
}

class FetchNews extends NewsEvent {
  final int page; // Add this line to include the 'page' parameter

  FetchNews({this.page = 1}); // Update the constructor

  @override
  List<Object> get props => [page];
}