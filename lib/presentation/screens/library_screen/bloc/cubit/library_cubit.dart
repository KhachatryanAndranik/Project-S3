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

  Future<void> fetchBooks() async {
    try {
      final books = await _booksRepository.fetchBooks();

      final bookViewModels = books.map((book) => book.toViewModel()).toList();

      emit(LibraryState.loaded(books: bookViewModels));
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
