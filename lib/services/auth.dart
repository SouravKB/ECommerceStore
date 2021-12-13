import 'dart:developer';

import 'package:ecommercestore/models/ui/user.dart';
import 'package:ecommercestore/repositories/user_repo.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class AuthService {
  final _auth = auth.FirebaseAuth.instance;

  User? _newUser(auth.User user, String? name, String email, String phoneNo) {
    return User(
        userId: user.uid,
        name: name ?? "",
        profilePicUrl: null,
        emailIds: [email],
        phoneNos: [phoneNo],
        addresses: []);
  }

  //auth change user stream
  Stream<String?> get userId {
    return _auth.authStateChanges().map((user) => user?.uid);
  }

  Future<String?> registerWithEmailAndPassword(
      String? name, String email, String password, String phoneNo) async {
    auth.UserCredential userCredentials = await _auth
        .createUserWithEmailAndPassword(email: email, password: password);
    if (userCredentials.user == null) {
      return null;
    }
    final user = _newUser(userCredentials.user!, name, email, phoneNo)!;
    final repo = UserRepo.instance;
    repo.addUser(user);
    return user.userId;
  }

  Future<String> signInWithEmailAndPassword(
      String email, String password) async {
    auth.UserCredential userCredentials = await _auth
        .signInWithEmailAndPassword(email: email, password: password);
    return userCredentials.user!.uid;
  }

  Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
