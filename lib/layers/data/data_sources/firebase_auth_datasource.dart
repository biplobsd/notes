import 'package:firebase_auth/firebase_auth.dart';
import 'package:notes/core/error/exceptions.dart';

class FirebaseAuthDataSource {
  final FirebaseAuth firebaseAuth;

  FirebaseAuthDataSource(this.firebaseAuth);

  Future<User?> signIn(String email, String password) async {
    try {
      UserCredential result = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } catch (e) {
      throw AuthException(message: e.toString());
    }
  }

  Future<User?> register(String email, String password, String name) async {
    try {
      UserCredential result = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await result.user?.updateDisplayName(name);
      return result.user;
    } catch (e) {
      throw AuthException(message: e.toString());
    }
  }

  Future<void> signOut() async {
    try {
      await firebaseAuth.signOut();
    } catch (e) {
      throw AuthException(message: e.toString());
    }
  }
}
