import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_app/domain.dart';
import 'package:library_app/presentation/common.dart';
import 'package:library_app/presentation/common/widgets/liberary_button.dart';
import 'package:library_app/presentation/routing.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (previous, current) =>
          previous is! AuthenticatedState && current is AuthenticatedState,
      listener: (context, state) {
        context.router.replaceAll([const LiberaryRoute()]);
      },
      child: LibraryScaffold(
        appBar: const LibraryAppBar(title: 'Login'),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _usernameController,
                    decoration: const InputDecoration(labelText: 'Username'),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                      ),
                    ),
                  ),
                  if (state.errorMessage != null &&
                      state.errorMessage!.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    Text(
                      state.errorMessage!,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: Colors.red),
                    ),
                  ],
                  const SizedBox(height: 24),
                  LiberaryButton.text(
                    label: 'Login',
                    onTap: () {
                      context.read<AuthCubit>().logIn(
                        LoginCredentials(
                          username: _usernameController.text,
                          password: _passwordController.text,
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  LiberaryButton.text(
                    label: 'Sign Up',
                    onTap: () {
                      context.read<AuthCubit>().resetError();
                      context.router.push(const SignUpRoute());
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
