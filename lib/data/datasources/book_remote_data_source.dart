import 'dart:convert';
import 'package:book/core/constant/api_constants.dart';
import 'package:book/data/model/book.dart';
import 'package:book/data/model/book_model.dart';
import 'package:book/domain/entries/book.dart';
import 'package:http/http.dart' as http;

// lib/data/datasources/book_remote_data_source.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/error/exception.dart';

abstract class RemoteDataSource {
  // This method fetches books from the remote server with pagination support.
  Future<List<BookEntity>> getBooks(int offset, int limit);
}
// remote_data_source_impl.dart

class RemoteDataSourceImpl implements RemoteDataSource {
  // Constructor for the RemoteDataSourceImpl, accepting an http.Client
  RemoteDataSourceImpl();

  // Fetch books with pagination
  @override
  Future<List<BookEntity>> getBooks(int offset, int limit) async{
    // API URL with page parameter
    final url = Uri.parse(
      '${ApiConstants.baseUrl}${ApiConstants.subjectEndpoint}',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      final List<dynamic> works = jsonResponse['works'];

      return works.map((json) => BookModel.fromJson(json).toEntity()).toList();
    } else {
      throw ServerException();
    }
  }
}
