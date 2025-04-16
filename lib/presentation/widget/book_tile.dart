
import 'package:book/domain/entries/book.dart';
import 'package:book/presentation/bloc/book/book_bloc.dart';
import 'package:book/presentation/bloc/book/book_event.dart';
import 'package:book/presentation/pages/book_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookTile extends StatelessWidget {
  final BookEntity book;

  const BookTile({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(book.title),
      subtitle: Text(book.authors.join(", ")),
      trailing: IconButton(
        icon: Icon(
          book.isFavourite ? Icons.favorite : Icons.favorite_border,
          color: book.isFavourite ? Colors.red : null,
        ),
        onPressed: () {
          context.read<BookBloc>().add(ToggleFavourite(book: book));
        },
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BookDetailPage(book: book)),
        );
      },
    );
  }
}
