import 'package:library_app/data/database/database_constants.dart';

const String createUsersTableSql = '''
CREATE TABLE IF NOT EXISTS ${DatabaseConstants.users} (
  ${DatabaseConstants.id} INTEGER PRIMARY KEY AUTOINCREMENT,
  ${DatabaseConstants.username} TEXT NOT NULL UNIQUE,
  ${DatabaseConstants.password} TEXT NOT NULL,
  ${DatabaseConstants.email} TEXT NOT NULL UNIQUE,
  ${DatabaseConstants.name} TEXT NOT NULL,
  ${DatabaseConstants.surname} TEXT NOT NULL
);
''';
