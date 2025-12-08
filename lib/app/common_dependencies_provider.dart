import 'package:flutter/material.dart';
import 'package:library_app/core.dart';
import 'package:provider/provider.dart';

class CommonDependenciesProvider extends StatelessWidget {
  const CommonDependenciesProvider({
    super.key,
    required this.di,
    required this.child,
  });

  final DI di;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider.value(value: BlocFactory(di: di)),
      ],
      child: child,
    );
  }
}