import 'package:book/data/datasources/SharedPreferencesService.dart';
import 'package:book/data/datasources/book_remote_data_source.dart';
import 'package:book/data/repositories/book_repository_impl.dart';
import 'package:book/domain/usecases/get_books.dart';
import 'package:book/presentation/bloc/book/book_bloc.dart';
import 'package:book/presentation/pages/book_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final remoteDataSource = RemoteDataSourceImpl();
  final bookRepository = BookRepositoryImpl(remoteDataSource);
  final getBooks = GetBooks(bookRepository);
  final prefs = await SharedPreferences.getInstance();
  final sharedPrefsService = SharedPreferencesService(prefs);

  runApp(MyApp(getBooks: getBooks, shared_preferences: sharedPrefsService));
}

class MyApp extends StatelessWidget {
  final GetBooks getBooks;

  final dynamic shared_preferences;

  const MyApp({
    super.key,
    required this.getBooks,
    required this.shared_preferences,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (_) => BookBloc(
            getBooks: getBooks,
            sharedPreferencesService: shared_preferences,
          ),
      child: MaterialApp(
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const BookListPage(),
      ),
    );
  }
}
