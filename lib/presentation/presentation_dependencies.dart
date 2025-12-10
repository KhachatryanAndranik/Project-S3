import 'package:library_app/core.dart';
import 'package:library_app/presentation/common.dart';

class PresentationDependencies extends PackageDependencies {
  @override
  Future<void> register(DI di) async {
    di.registerLazySingleton(
      () => AuthCubit(authRepository: di()),
    );
  }
}
