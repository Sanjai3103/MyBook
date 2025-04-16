import 'package:dartz/dartz.dart';
import 'package:book/core/error/failure.dart';
import 'package:book/domain/entries/book.dart';

abstract class BookRepository {
  Future<Either<Failure, List<BookEntity>>> getBooks(int offset, int limit);
}
