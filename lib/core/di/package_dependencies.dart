import 'package:library_app/core/di/di.dart';

abstract class PackageDependencies {
  Future<void> register(DI di);
}
