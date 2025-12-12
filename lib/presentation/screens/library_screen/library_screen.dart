import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_app/presentation/common.dart';
import 'package:library_app/presentation/routing/app_router.dart';
import 'package:library_app/presentation/screens/library_screen/view_models.dart';
import 'package:library_app/presentation/screens/library_screen/widgets/book_card.dart';

@RoutePage()
class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (previous, current) =>
          previous is! UnauthenticatedState && current is UnauthenticatedState,
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
        body: ListView.separated(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).padding.bottom + 16,
            top: 16,
            left: 16,
            right: 16,
          ),
          itemCount: booksMock.length,
          itemBuilder: (context, index) => BookCard(book: booksMock[index]),
          separatorBuilder: (context, index) => const SizedBox(height: 16),
        ),
      ),
    );
  }
}
