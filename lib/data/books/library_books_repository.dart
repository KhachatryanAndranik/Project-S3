import 'package:library_app/data.dart';
import 'package:library_app/domain.dart';

class LibraryBooksRepository implements BooksRepository {
  const LibraryBooksRepository({
    required BooksDataSource booksLocalDataSource,
    required AuthDataSource authLocalDataSource,
  }) : _booksLocalDataSource = booksLocalDataSource,
       _authLocalDataSource = authLocalDataSource;

  final BooksDataSource _booksLocalDataSource;
  final AuthDataSource _authLocalDataSource;

  @override
  Future<List<Book>> fetchBooks() async {
    final booksDto = await _booksLocalDataSource.fetchBooks();
    final books = <Book>[];
    final borrowedBooks = await _booksLocalDataSource.fetchBorrowedBooks();

    for (final bookDto in booksDto) {
      books.add(Book.fromDto(bookDto));

      try {
        final borrowedBook = borrowedBooks.firstWhere(
          (book) => book.bookId == bookDto.id,
        );

        final user = await _authLocalDataSource.fetchUserById(
          borrowedBook.userId,
        );

        if (user == null) {
          continue;
        }

        final updatedBookDto = bookDto.copyWith(
          borrowedData: BorrowedBookDto(
            user: user,
            dueDate: borrowedBook.dueDate ?? DateTime.now(),
            borrowedDate: borrowedBook.borrowedDate ?? DateTime.now(),
          ),
        );

        books.removeLast();
        books.add(Book.fromDto(updatedBookDto));
      } catch (_) {}
    }

    return books;
  }

  @override
  Future<void> borrowBook(BorrowBookData borrowData) {
    return _booksLocalDataSource.borrowBook(borrowData);
  }

  @override
  Future<void> returnBook(BorrowBookData borrowData) {
    return _booksLocalDataSource.returnBook(borrowData);
  }
}
