import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:notes/layers/presentation/providers/auth_view_model_provider.dart';

class RegistrationPage extends ConsumerWidget {
  const RegistrationPage({super.key});

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
                  "Registration",
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
                TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Confirm password",
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
                      await model.register();
                      context.goNamed('/home');
                    } catch (e) {
                      // TODO
                      ScaffoldMessenger.of(context)
                          .showSnackBar(const SnackBar(content: Text('Error')));
                    }
                  },
                  child: const Text(
                    "REGISTER",
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
                    onTap: () => context.goNamed('/login'),
                    child: const Text("Have a account? Login Now"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
