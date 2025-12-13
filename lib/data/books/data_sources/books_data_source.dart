import 'package:library_app/data.dart';
import 'package:library_app/domain.dart';

abstract class BooksDataSource {
  Future<List<BookDto>> fetchBooks();
  Future<void> borrowBook(BorrowBookData borrowData);
  Future<void> returnBook(BorrowBookData borrowData);
  Future<List<BorrowBookData>> fetchBorrowedBooks();
}
