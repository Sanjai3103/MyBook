
import 'package:book/domain/entries/book.dart';
import 'package:equatable/equatable.dart';

abstract class BookState extends Equatable {
  const BookState();

  @override
  List<Object?> get props => [];
}

class BookInitial extends BookState {}

class BookLoading extends BookState {}

class BookLoaded extends BookState {
  final List<BookEntity> books;
  final List<BookEntity> favouriteBooks;
  final bool hasReachedMax; 
    final int page;
  const BookLoaded({required this.books, required this.favouriteBooks,required this.hasReachedMax,required this.page});

  @override
  List<Object?> get props => [books, favouriteBooks];
}

class BookError extends BookState {
  final String message;

  const BookError(this.message);

  @override
  List<Object?> get props => [message];
}
