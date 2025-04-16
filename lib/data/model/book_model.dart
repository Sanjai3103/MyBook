import 'package:book/domain/entries/book.dart';

class BookModel extends BookEntity {
  const BookModel({
    required String title,
    required String id,
    required String key,
    required List<String> authors,
    required int coverId,
    required int firstPublishYear,
    required List<String> subjects,
    List<BookEntity> books = const [],
    List<BookEntity> favourites = const [],
    bool isLoading = false,
    String author = '',
    String coverImage = '',
    bool isFavourite = false,
  }) : super(
         title: title,
         key: key,
         id: id,
         authors: authors,
         coverId: coverId,
         firstPublishYear: firstPublishYear,
         subjects: subjects,
         books: books,
         favourites: favourites,
         isLoading: isLoading,
         author: author,
         coverImage: coverImage,
         isFavourite: isFavourite,
       );

  factory BookModel.fromJson(Map<String, dynamic> json) {
    final authorsList =
        (json['authors'] as List?)?.map((e) => e['name'] as String).toList() ??
        [];

    return BookModel(
      title: json['title'] ?? 'Unknown Title',
      key: json['key'] ?? '',
      authors: authorsList,
      coverId: json['cover_id'] ?? 0,
      firstPublishYear: json['first_publish_year'] ?? 0,
      subjects:
          (json['subject'] as List?)?.map((e) => e.toString()).toList() ?? [],
      author: authorsList.isNotEmpty ? authorsList[0] : 'Unknown Author',
      coverImage:
          json['cover_i'] != null
              ? 'https://covers.openlibrary.org/b/id/${json['cover_i']}-L.jpg'
              : '',
      id: '',
    );
  }

  BookEntity toEntity() => BookEntity(
    title: title,
    key: key,
    authors: authors,
    coverId: coverId,
    firstPublishYear: firstPublishYear,
    subjects: subjects,
    books: books,
    favourites: favourites,
    isLoading: isLoading,
    author: author,
    coverImage: coverImage,
    id: '',
  );
}
