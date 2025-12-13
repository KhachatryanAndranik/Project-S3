import 'package:library_app/data.dart';
import 'package:library_app/domain.dart';

class BooksRemoteDataSource implements BooksDataSource {
  @override
  Future<void> borrowBook(BorrowBookData borrowData) {
    throw UnimplementedError();
  }

  @override
  Future<List<BookDto>> fetchBooks() {
    throw UnimplementedError();
  }

  @override
  Future<void> returnBook(BorrowBookData borrowData) {
    throw UnimplementedError();
  }

  @override
  Future<List<BorrowBookData>> fetchBorrowedBooks() {
    throw UnimplementedError();
  }
}
