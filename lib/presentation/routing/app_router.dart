import 'package:auto_route/auto_route.dart';
import 'package:library_app/core.dart';
import 'package:library_app/presentation/screens.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  AppRouter({required this.di});

  final DI di;

  @override
  List<AutoRoute> get routes => [
    AutoRoute(initial: true, path: RoutePath.login, page: LoginRoute.page),
  ];
}

class RoutePath {
  static const login = '/login';
}
