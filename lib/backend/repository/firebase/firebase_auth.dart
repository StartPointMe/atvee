import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthentication implements AuthCredential {
  final firebaseAuth = FirebaseAuth.instance;

  Future<User?> registerUser(String email, String password) async {
    final userCredentials = await firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    userCredentials.user!.sendEmailVerification();
    return userCredentials.user;
  }

  Future<User?> signIn(String email, String password) async {
    final userCredentials = await firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return userCredentials.user;
  }

  Future<void> resetPassword(String email) async {
    await firebaseAuth.sendPasswordResetEmail(email: email);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
