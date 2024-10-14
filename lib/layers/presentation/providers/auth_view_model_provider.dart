import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authViewModelProvider = ChangeNotifierProvider(
  (ref) => AuthViewModelProvider(),
);

class AuthViewModelProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String _email = '';
  String get email => _email;
  set email(String email) {
    _email = email;
    notifyListeners();
  }

  String _password = '';
  String get password => _password;
  set password(String password) {
    _password = password;
    notifyListeners();
  }

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  Future<void> login() async {
    loading = true;
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      // TODO: Later task
      loading = false;
      return Future.error(e);
    }
    loading = false;
  }

  Future<void> register() async {
    loading = true;
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      // TODO: Later task
      loading = false;
      return Future.error(e);
    }
    loading = false;
  }
}
