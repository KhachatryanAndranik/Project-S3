import 'package:library_app/core.dart';
import 'package:library_app/presentation/common.dart';
import 'package:library_app/presentation/screens/library_screen/bloc/cubit/library_cubit.dart';

class PresentationDependencies extends PackageDependencies {
  @override
  Future<void> register(DI di) async {
    di.registerLazySingleton(() => AuthCubit(authRepository: di()));

    di.registerFactory(() => LibraryCubit(booksRepository: di()));
  }
}
