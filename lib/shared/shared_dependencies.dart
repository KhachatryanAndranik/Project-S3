import 'package:library_app/core.dart';
import 'package:library_app/shared.dart';

class SharedDependencies extends PackageDependencies {
  @override
  Future<void> register(DI di) async {
    di
      ..registerLazySingleton<CustomJsonDecoder>(() => CustomJsonDecoder([]))
      ..registerLazySingleton<JsonStringConverter>(
        () => JsonStringConverter(jsonDecoder: di()),
      );

    final appKeyValueStorage = await DeviceKeyValueStorage.create(
      jsonStringConverter: di(),
    );

    di.registerSingleton<KeyValueStorage>(appKeyValueStorage);

    final dataScraper = PythonDataScraper(jsonStringConverter: di());

    di.registerLazySingleton<DataScraper>(() => dataScraper);
  }
}
