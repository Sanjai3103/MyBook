

class BookEntity {
  final String title;
  final String key;
  final List<String> authors;
  final int coverId;
  final int firstPublishYear;
  final List<String> subjects;
  final List<BookEntity> books;
  final List<BookEntity> favourites;
  final bool isLoading;
  final String author;
  final String coverImage;
    final bool isFavourite;

  const BookEntity({
    required this.title,
    required this.key,
    required this.authors,
    required this.coverId,
    required this.firstPublishYear,
    required this.subjects,
    this.books = const [],
    this.favourites = const [],
    this.isFavourite = false,
    this.isLoading = false,
    this.author = '',
    this.coverImage = '', required String id,
  });


  factory BookEntity.fromJson(Map<String, dynamic> json) {
    return BookEntity(
      title: json['title'] ?? '',
      author: json['author'] ?? '',
      coverImage: json['cover_image'] ?? '', key: '', authors: [], coverId: 0, firstPublishYear:0, subjects: [], id: '',
    );
  }

  BookEntity toEntity() {
    return BookEntity(title: title, author: author, coverImage: coverImage, key: '', authors: [], coverId: 0, firstPublishYear: 0, subjects: [], id: '');
  }
  BookEntity copyWith({bool? isFavourite}) {
    return BookEntity(
      title: title,
      key: key,
      authors: authors,
      coverId: coverId,
      firstPublishYear: firstPublishYear,
      subjects: subjects,
      isFavourite: isFavourite ?? this.isFavourite, id: '',
    );
  }

}

