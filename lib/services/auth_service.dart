import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  AuthService._();

  static final _auth = FirebaseAuth.instance;

  Stream<String?> get userId {
    return _auth.authStateChanges().map((user) => user?.uid);
  }

  Future<String?> registerWithEmailAndPassword(
      String email, String password) async {
    final credentials = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    return credentials.user?.uid;
  }

  Future<String?> loginWithEmailAndPassword(
      String email, String password) async {
    final credentials = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return credentials.user?.uid;
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  Future<void> resetPasswordWithEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  static final instance = AuthService._();
}
