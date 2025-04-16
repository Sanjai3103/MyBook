
import 'package:book/presentation/bloc/book/book_bloc.dart';
import 'package:book/presentation/bloc/book/book_event.dart';
import 'package:book/presentation/bloc/book/book_state.dart';
import 'package:book/presentation/pages/FavouriteBooksPage.dart';
import 'package:book/presentation/widget/book_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookListPage extends StatefulWidget {
  const BookListPage({super.key});

  @override
  State<BookListPage> createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    context.read<BookBloc>().add(FetchBooks(page: 0));
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
   
        context.read<BookBloc>().add(FetchBooks(page: 0));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<BookBloc>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[50],
        title: const Text("MyBooks"),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FavouriteBooksPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<BookBloc, BookState>(
        builder: (context, state) {
          if (state is BookInitial || state is BookLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is BookLoaded) {
            return NotificationListener<ScrollNotification>(
              onNotification: (scrollNotification) {
                if (scrollNotification.metrics.pixels >=
                        scrollNotification.metrics.maxScrollExtent - 200 &&
                    !state.hasReachedMax &&
                    !(state is BookLoading)) {
                  context.read<BookBloc>().add(FetchBooks(page: 0));
                }
                return false;
              },
              child: Container(
                color: Colors.lightBlue[50],
                child: ListView.separated(
                  controller: _scrollController,
                  separatorBuilder:
                      (context, index) =>
                          Divider(thickness: 1, color: Colors.grey[300]),
                  itemCount: state.books.length,
                  itemBuilder: (context, index) {
                    return BookTile(book: state.books[index]);
                  },
                ),
              ),
            );
          } else if (state is BookError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox();
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
