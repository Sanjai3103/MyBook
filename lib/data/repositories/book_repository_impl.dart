// book_repository_impl.dart

import 'package:book/core/error/exception.dart';
import 'package:book/core/error/failure.dart';
import 'package:book/data/datasources/book_remote_data_source.dart';

import 'package:book/domain/entries/book.dart';
import 'package:book/domain/repository/book_repository.dart';
import 'package:dartz/dartz.dart';

class BookRepositoryImpl implements BookRepository {
  final RemoteDataSource remoteDataSource;

  // Constructor for BookRepositoryImpl
  BookRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<BookEntity>>> getBooks(
    int offset,
    int limit,
  ) async {
    try {
      // Pass the page number to the data source to fetch paginated books
      final books = await remoteDataSource.getBooks(offset, limit);
      return Right(books); // Return the books wrapped in a Right (Success)
    } on ServerException catch (e) {
      // Handle server exceptions and return an error failure
      return Left(
        ServerFailure("Failed to fetch books from the server: ${e.toString()}"),
      );
    } catch (e) {
      // Catch any other exceptions and return a generic failure message
      return Left(ServerFailure("An unexpected error occurred: $e"));
    }
  }
}
