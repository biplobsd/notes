import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:notes/layers/presentation/providers/auth_view_model_provider.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(authViewModelProvider);
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Login",
                  style: TextStyle(fontSize: 40),
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (v) => model.email = v!,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    prefixIcon: Icon(Icons.email),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  obscureText: true,
                  onSaved: (v) => model.password = v!,
                  decoration: const InputDecoration(
                    labelText: "Password",
                    prefixIcon: Icon(Icons.password),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () async {
                    formKey.currentState!.save();
                    try {
                      await model.login();
                      context.goNamed('/home');
                    } catch (e) {
                      // TODO
                      ScaffoldMessenger.of(context)
                          .showSnackBar(const SnackBar(content: Text('Error')));
                    }
                  },
                  child: const Text(
                    "LOGIN",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                if (model.loading)
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
                InkWell(
                    onTap: () => context.goNamed('/register'),
                    child: const Text("Don't have a account? Register Now"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
