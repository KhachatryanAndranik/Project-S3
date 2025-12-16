import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_app/domain.dart';
import 'package:library_app/presentation/screens/library_screen/view_models.dart';

part 'library_state.dart';

class LibraryCubit extends Cubit<LibraryState> {
  LibraryCubit({required BooksRepository booksRepository})
    : _booksRepository = booksRepository,
      super(LibraryState.loading()) {
    fetchBooks();
  }

  final BooksRepository _booksRepository;
  var _allBooks = <BookViewModel>[];
  var _searchQuery = '';

  Future<void> searchBooks(String query) async {
    _searchQuery = query;
    final normalized = query.trim().toLowerCase();

    if (normalized.isEmpty) {
      emit(LibraryState.loaded(books: _allBooks));

      return;
    }

    final filteredBooks = _allBooks
        .where(
          (book) =>
              book.title.toLowerCase().contains(normalized) ||
              book.authorName.toLowerCase().contains(normalized),
        )
        .toList();

    emit(LibraryState.loaded(books: filteredBooks));
  }

  Future<void> fetchBooks() async {
    try {
      final books = await _booksRepository.fetchBooks();

      final bookViewModels = books.map((book) => book.toViewModel()).toList();

      _allBooks = bookViewModels;

      await searchBooks(_searchQuery);
    } catch (e) {
      emit(LibraryState.error(message: e.toString()));
    }
  }

  Future<void> borrowBook(BorrowBookData borrowBookData) async {
    try {
      await _booksRepository.borrowBook(borrowBookData);

      fetchBooks();
    } catch (e) {
      emit(LibraryState.error(message: e.toString()));
    }
  }

  Future<void> returnBook(BorrowBookData borrowBookData) async {
    try {
      await _booksRepository.returnBook(borrowBookData);

      fetchBooks();
    } catch (e) {
      emit(LibraryState.error(message: e.toString()));
    }
  }
}
