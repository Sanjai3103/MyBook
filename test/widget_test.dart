// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:book/data/datasources/SharedPreferencesService.dart';
import 'package:book/data/datasources/book_remote_data_source.dart';
import 'package:book/data/repositories/book_repository_impl.dart';
import 'package:book/domain/usecases/get_books.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:book/main.dart';

void main() {
    final remoteDataSource = RemoteDataSourceImpl();
  final bookRepository = BookRepositoryImpl(remoteDataSource);
    final getBooks = GetBooks(bookRepository);
      final sharedPreferencesService = SharedPreferencesService();

  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp(getBooks:getBooks,shared_preferences: sharedPreferencesService));

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
