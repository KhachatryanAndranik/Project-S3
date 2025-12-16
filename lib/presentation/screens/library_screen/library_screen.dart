import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_app/core/bloc/bloc_factory.dart';
import 'package:library_app/presentation/common.dart';
import 'package:library_app/presentation/routing/app_router.dart';
import 'package:library_app/presentation/screens/library_screen/bloc/cubit/library_cubit.dart';
import 'package:library_app/presentation/screens/library_screen/widgets/book_card.dart';
import 'package:library_app/presentation/screens/library_screen/widgets/search_book_section.dart';

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
      child: BlocProvider<LibraryCubit>(
        create: (context) => context.read<BlocFactory>().get(),
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
          body: BlocBuilder<LibraryCubit, LibraryState>(
            builder: (context, state) {
              if (state is LibraryLoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is LibraryErrorState) {
                return Center(child: Text('Error: ${state.message}'));
              } else if (state is LibraryLoadedState) {
                final books = state.books;

                return Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Column(
                    children: [
                      SearchBookSection(
                        onQueryChanged: context
                            .read<LibraryCubit>()
                            .searchBooks,
                      ),
                      Expanded(
                        child: books.isEmpty
                            ? const Center(child: Text('No books found'))
                            : ListView.separated(
                                padding: EdgeInsets.only(
                                  bottom: 16,
                                  top: 16,
                                  left: 16,
                                  right: 16,
                                ),
                                itemCount: books.length,
                                itemBuilder: (context, index) =>
                                    BookCard(book: books[index]),
                                separatorBuilder: (context, index) =>
                                    const SizedBox(height: 16),
                              ),
                      ),
                    ],
                  ),
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
