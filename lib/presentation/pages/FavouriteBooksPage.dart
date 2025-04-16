import 'package:book/presentation/bloc/book/book_bloc.dart';
import 'package:book/presentation/bloc/book/book_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../pages/book_detail_page.dart';

class FavouriteBooksPage extends StatelessWidget {
  const FavouriteBooksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      appBar: AppBar(
        title: const Text("Favourite Books"),
        backgroundColor: Colors.lightBlue[50],
      ),
      body: BlocBuilder<BookBloc, BookState>(
        builder: (context, state) {
          if (state is BookLoaded) {
            final favouriteBooks = state.favouriteBooks;

            if (favouriteBooks.isEmpty) {
              return const Center(child: Text("No favourite books yet."));
            }

            return ListView.builder(
              itemCount: favouriteBooks.length,
              itemBuilder: (context, index) {
                final book = favouriteBooks[index];
                return ListTile(
                  title: Text(book.title),
                  subtitle: Text(book.authors.join(", ")),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BookDetailPage(book: book),
                      ),
                    );
                  },
                );
              },
            );
          } else if (state is BookLoading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return const Center(child: Text("Unable to load favourites."));
          }
        },
      ),
    );
  }
}
