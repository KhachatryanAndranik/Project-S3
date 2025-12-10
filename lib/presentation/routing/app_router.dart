import 'package:auto_route/auto_route.dart';
import 'package:library_app/core.dart';
import 'package:library_app/presentation/routing/guards.dart';
import 'package:library_app/presentation/screens.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  AppRouter({required this.di});

  final DI di;

  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      initial: true,
      path: RoutePath.login,
      page: LoginRoute.page,
      guards: [AuthRouteGuard(authCubit: di())],
    ),
    AutoRoute(path: RoutePath.signUp, page: SignUpRoute.page),
    AutoRoute(path: RoutePath.liberary, page: LiberaryRoute.page),
  ];
}

class RoutePath {
  static const login = '/login';
  static const signUp = '/sign_up';
  static const liberary = '/liberary';
}
