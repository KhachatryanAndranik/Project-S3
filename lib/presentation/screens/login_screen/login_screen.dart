import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:library_app/presentation/common/widgets/library_app_bar.dart';

@RoutePage()
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const LibraryAppBar(),
    );
  }
}