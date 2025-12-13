import 'package:library_app/data/database/database_constants.dart';

const String borrowedBooks = '''
CREATE TABLE IF NOT EXISTS ${DatabaseConstants.borrowedBooks} (
  ${DatabaseConstants.userId} INTEGER NOT NULL,
  ${DatabaseConstants.bookId} TEXT NOT NULL,
  ${DatabaseConstants.borrowedDate} TEXT NOT NULL,
  ${DatabaseConstants.dueDate} TEXT NOT NULL
);
''';