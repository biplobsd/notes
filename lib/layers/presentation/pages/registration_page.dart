import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes/layers/presentation/providers/auth_provider.dart';
import 'package:notes/layers/presentation/widgets/register_form.dart';

class RegistrationPage extends ConsumerWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Register")),
      body: authState.when(
        initial: () => RegisterForm(),
        loading: () => const Center(child: CircularProgressIndicator()),
        authenticated: (user) => Center(child: Text('Welcome, ${user.email}!')),
        error: (message) => Center(child: Text(message)),
      ),
    );
  }
}
