import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_app/presentation/common.dart';
import 'package:library_app/presentation/routing/app_router.dart';

@RoutePage()
class LiberaryScreen extends StatelessWidget {
  const LiberaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (previous, current) => previous is! UnauthenticatedState && current is UnauthenticatedState,
      listener: (context, state) {
        context.router.replaceAll([const LoginRoute()]);
      },
      child: LibraryScaffold(
        appBar: LibraryAppBar(
          title: 'Library',
          actions: [
            IconButton(
              onPressed: () => context.read<AuthCubit>().logOut(),
              icon: const Icon(Icons.logout, color: Colors.white),
              tooltip: 'Log out',
            ),
          ],
        ),
      ),
    );
  }
}
