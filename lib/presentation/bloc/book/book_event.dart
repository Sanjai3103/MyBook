
import 'package:book/domain/entries/book.dart';
import 'package:equatable/equatable.dart';

abstract class BookEvent extends Equatable {
  const BookEvent();

  @override
  List<Object?> get props => [];
}

class FetchBooks extends BookEvent {
  final int page;

  FetchBooks({required this.page});
}

class ToggleFavourite extends BookEvent {
  final BookEntity book;

  ToggleFavourite({required this.book});

  @override
  List<Object?> get props => [book];
}

class LoadMoreBooks extends BookEvent {}
