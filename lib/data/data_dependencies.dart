import 'package:library_app/core.dart';
import 'package:library_app/data.dart';
import 'package:library_app/domain.dart';

class DataDependencies extends PackageDependencies {
  @override
  Future<void> register(DI di) async {
    final migrations = <CacheMigration>[
      (CacheDatabase db) async {
        await db.execute(createUsersTableSql);
      },
    ];

    final cacheDb = SqfliteCacheDatabase(
      databaseName: 'library_app_cache.db',
      migrations: migrations,
    );

    await cacheDb.init();

    di.registerLazySingleton<CacheDatabase>(() => cacheDb);

    di.registerLazySingleton(
      () => AuthLocalDataSource(
        cacheDatabase: di<CacheDatabase>(),
        deviceKeyValueStorage: di(),
      ),
    );

    di.registerLazySingleton<AuthRepository>(
      () => LiberaryAuthRepository(
        authLocalDataSource: di<AuthLocalDataSource>(),
      ),
    );
  }
}
