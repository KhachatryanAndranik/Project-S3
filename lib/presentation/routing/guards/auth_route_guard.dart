import 'package:auto_route/auto_route.dart';
import 'package:library_app/presentation/common/blocs/auth.dart';
import 'package:library_app/presentation/routing/app_router.dart';

class AuthRouteGuard extends AutoRouteGuard {
  AuthRouteGuard({required AuthCubit authCubit}) : _authCubit = authCubit;

  final AuthCubit _authCubit;

  @override
  Future<void> onNavigation(
    NavigationResolver resolver,
    StackRouter router,
  ) async {
    final isAuthenticated = await _authCubit.checkAuthenticatedUser();

    if (isAuthenticated) {
      router.replaceAll([const LibraryRoute()]);

      return;
    }

    resolver.next();
  }
}
