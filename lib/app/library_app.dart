import 'package:flutter/material.dart';
import 'package:library_app/app/common_dependencies_provider.dart';
import 'package:library_app/core.dart';
import 'package:library_app/presentation/routing/app_router.dart';

class LibraryApp extends StatefulWidget {
  const LibraryApp({
    super.key,
    required this.di,
  });

  final DI di;

  @override
  State<LibraryApp> createState() => _LibraryAppState();
}

class _LibraryAppState extends State<LibraryApp> {
  late AppRouter _router;

  @override
  void initState() {
    super.initState();

    _router = AppRouter(
      di: widget.di,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router.config(),
      builder: (context, child) {
        return CommonDependenciesProvider(
          di: widget.di,
          child: child!
        );
      },
    );
  }
}