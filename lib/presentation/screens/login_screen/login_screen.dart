import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:library_app/presentation/common.dart';

@RoutePage()
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LibraryScaffold(appBar: const LibraryAppBar(title: 'Login'));
  }
}
