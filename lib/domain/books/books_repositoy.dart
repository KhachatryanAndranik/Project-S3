import 'package:library_app/domain.dart';

abstract class BooksRepository {
  Future<List<Book>> fetchBooks();
  Future<void> borrowBook(BorrowBookData borrowData);
  Future<void> returnBook(BorrowBookData borrowData);
}
