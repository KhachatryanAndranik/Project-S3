import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:library_app/core.dart';
import 'package:library_app/data.dart';
import 'package:library_app/domain.dart';
import 'package:library_app/shared.dart';

class BooksLocalDataSource implements BooksDataSource {
  const BooksLocalDataSource({
    required CacheDatabase cacheDatabase,
    required JsonStringConverter jsonStringConverter,
  }) : _cacheDatabase = cacheDatabase,
       _jsonStringConverter = jsonStringConverter;

  final CacheDatabase _cacheDatabase;
  final JsonStringConverter _jsonStringConverter;

  @override
  Future<List<BookDto>> fetchBooks() async {
    final jsonString = await rootBundle.loadString(
      'assets/books_data/books_via_api.json',
    );

    final booksJson = jsonDecode(jsonString);

    if (booksJson is! List) {
      return [];
    }

    final books = <BookDto>[];

    for (final bookJson in booksJson) {
      final book = _jsonStringConverter.fromJsonString<BookDto>(bookJson);

      books.add(book);
    }

    return books;
  }

  @override
  Future<void> borrowBook(BorrowBookData borrowData) async {
    await _cacheDatabase.query(
      'INSERT INTO ${DatabaseConstants.borrowedBooks} ('
      '${DatabaseConstants.userId}, ${DatabaseConstants.bookId}, '
      '${DatabaseConstants.dueDate}, ${DatabaseConstants.borrowedDate}'
      ') VALUES (?, ?, ?, ?)',
      arguments: [
        borrowData.userId,
        borrowData.bookId,
        borrowData.dueDate?.toIso8601String(),
        borrowData.borrowedDate?.toIso8601String(),
      ],
    );
  }

  @override
  Future<void> returnBook(BorrowBookData borrowData) async {
    await _cacheDatabase.query(
      'DELETE FROM ${DatabaseConstants.borrowedBooks} '
      'WHERE ${DatabaseConstants.userId} = ? '
      'AND ${DatabaseConstants.bookId} = ?',
      arguments: [borrowData.userId, borrowData.bookId],
    );
  }

  @override
  Future<List<BorrowBookData>> fetchBorrowedBooks() async {
    final rows = await _cacheDatabase.query(
      'SELECT * FROM ${DatabaseConstants.borrowedBooks}',
    );

    return rows.map((row) => BorrowBookData.fromJson(row)).toList();
  }
}
