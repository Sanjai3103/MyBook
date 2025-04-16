import 'package:book/core/error/failure.dart';
import 'package:book/data/datasources/SharedPreferencesService.dart';

import 'package:book/domain/entries/book.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../domain/usecases/get_books.dart';
import 'book_event.dart';
import 'book_state.dart';


class BookBloc extends Bloc<BookEvent, BookState> {
  final GetBooks getBooks;
  final SharedPreferencesService sharedPreferencesService;
  final List<BookEntity> _favourites = [];
  bool isFetching = false;
  BookBloc({required this.getBooks, required this.sharedPreferencesService})
    : super(BookInitial()) {
    on<FetchBooks>(_onFetchBooks);
    on<ToggleFavourite>(_onToggleFavourite);
    _loadFavouriteBooks();
  }


  Future<void> _loadFavouriteBooks() async {
    final favouriteIds = await sharedPreferencesService.loadFavouriteBooks();
    _favourites.clear();

   
    _favourites.addAll(
      favouriteIds.map(
        (id) => BookEntity(
          id: id,
          isFavourite: true,
          title: '',
          key: '',
          authors: [],
          coverId: 0,
          firstPublishYear: 0,
          subjects: [],
        ),
      ),
    ); 
  }

  Future<void> _onFetchBooks(FetchBooks event, Emitter<BookState> emit) async {
    if (state is BookLoaded && (state as BookLoaded).hasReachedMax) return;

    if (state is BookLoading) return; 

    final currentState = state;
    int currentPage = 0;
    bool hasReachedMax = false;
    List<BookEntity> currentBooks = [];
    final int _limit = 20;

    final int offset = currentPage * _limit;


    if (currentState is BookLoaded) {
      currentPage = currentState.page;
      hasReachedMax = currentState.hasReachedMax;
      currentBooks = currentState.books;
    }

    if (hasReachedMax)
      return; 

    emit(BookLoading());

    final result = await getBooks(
      offset,
      _limit,
    ); 

    result.fold(
      (failure) {
        emit(BookError(_mapFailureToMessage(failure)));
      },
      (books) {
        final favKeys = sharedPreferencesService.loadFavourites();

       
        final updatedNewBooks =
            books.map((book) {
              final isFavourite = favKeys.contains(book.key);
              return book.copyWith(isFavourite: isFavourite);
            }).toList();

       
        _favourites.addAll(
          updatedNewBooks.where(
            (b) => b.isFavourite && !_favourites.any((f) => f.key == b.key),
          ),
        );

        final allBooks = [...currentBooks, ...updatedNewBooks];

        emit(
          BookLoaded(
            books: [...currentBooks, ...updatedNewBooks],
            favouriteBooks: _favourites,
            page: currentPage + 1,
            hasReachedMax:
                books
                    .isEmpty, 
          ),
        );
      },
    );
  }

  void _onToggleFavourite(ToggleFavourite event, Emitter<BookState> emit) {
    final isFav = _favourites.any((b) => b.key == event.book.key);

    if (isFav) {
      _favourites.removeWhere((b) => b.key == event.book.key);
    } else {
      _favourites.add(event.book);
    }

   
    final favouriteIds = _favourites.map((b) => b.key).toList();

    sharedPreferencesService.saveFavourites(
      _favourites.map((b) => b.key).toList(),
    );
    if (state is BookLoaded) {
      final currentState = state as BookLoaded;


      final updatedBooks =
          currentState.books.map((book) {
            final isFavourite = _favourites.any((fav) => fav.key == book.key);
            return book.copyWith(isFavourite: isFavourite);
          }).toList();

      emit(
        BookLoaded(
          books: updatedBooks,
          favouriteBooks: List.from(_favourites),
          page: 0,
          hasReachedMax: false,
        ),
      );
    }
  }

  String _mapFailureToMessage(Failure failure) {
    return 'An unexpected error occurred';
  }
}
