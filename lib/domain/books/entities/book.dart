import 'package:library_app/data.dart';
import 'package:library_app/domain.dart';
import 'package:library_app/presentation/screens/library_screen/view_models.dart';

class Book {
  const Book({
    required this.id,
    required this.title,
    required this.author,
    this.borrowedData,
    this.coverImageUrl,
  });

  final String id;
  final String title;
  final String author;
  final String? coverImageUrl;
  final BorrowedBookData? borrowedData;

  factory Book.fromDto(BookDto dto) {
    return Book(
      id: dto.id ?? '',
      title: dto.title ?? '',
      author: dto.author ?? '',
      coverImageUrl: dto.coverImageUrl,
    );
  }

  BookViewModel toViewModel() {
    return BookViewModel(
      id: id,
      title: title,
      authorName: author,
      coverImageUrl: coverImageUrl,
      borrowedInfo: borrowedData?.toViewModel(),
    );
  }

  Book copyWith({
    String? id,
    String? title,
    String? author,
    String? coverImageUrl,
    BorrowedBookData? borrowedData,
  }) {
    return Book(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      coverImageUrl: coverImageUrl ?? this.coverImageUrl,
      borrowedData: borrowedData ?? this.borrowedData,
    );
  }
}
