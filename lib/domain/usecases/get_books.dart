import 'package:book/core/error/failure.dart';
import 'package:book/domain/entries/book.dart';
import 'package:book/domain/repository/book_repository.dart';
import 'package:dartz/dartz.dart';

class GetBooks {
  final BookRepository repository;

  GetBooks(this.repository);

  Future<Either<Failure, List<BookEntity>>> call(int offset, int limit) {
    return repository.getBooks(offset, limit);
  }
}
