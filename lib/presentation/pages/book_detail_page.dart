import 'package:book/presentation/bloc/book/book_bloc.dart';
import 'package:book/presentation/bloc/book/book_event.dart';
import 'package:book/presentation/bloc/book/book_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entries/book.dart';

class BookDetailPage extends StatelessWidget {
  final BookEntity book;

  const BookDetailPage({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<BookBloc>();

    final isFavourite =
        (bloc.state is BookLoaded &&
            (bloc.state as BookLoaded).favouriteBooks.contains(book));

    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      appBar: AppBar(
        title: Text(book.title),
        backgroundColor: Colors.lightBlue[50],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "Title: ${book.title}",
                        style: const TextStyle(fontSize: 20),
                      ),
                      const SizedBox(height: 10),
                      Text("Author(s): ${book.authors.join(", ")}"),
                      const SizedBox(height: 10),
                      Text("First Published: ${book.firstPublishYear}"),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: Icon(
                      isFavourite ? Icons.favorite : Icons.favorite_border,
                      color: isFavourite ? Colors.red : null,
                    ),
                    onPressed: () {
                      bloc.add(ToggleFavourite(book: book));
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: [
                  const SizedBox(height: 10),
                  Text("Subjects: ${book.subjects.join(", ")}"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
