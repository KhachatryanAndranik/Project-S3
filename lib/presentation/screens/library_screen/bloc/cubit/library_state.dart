part of 'library_cubit.dart';

abstract class LibraryState {
  const LibraryState();

  factory LibraryState.loading() = LibraryLoadingState;
  factory LibraryState.loaded({required List<BookViewModel> books}) =
      LibraryLoadedState;
  factory LibraryState.error({required String message}) = LibraryErrorState;
}

class LibraryLoadingState extends LibraryState {
  const LibraryLoadingState();
}

class LibraryLoadedState extends LibraryState {
  const LibraryLoadedState({required this.books});

  final List<BookViewModel> books;
}

class LibraryErrorState extends LibraryState {
  const LibraryErrorState({required this.message});

  final String message;
}
