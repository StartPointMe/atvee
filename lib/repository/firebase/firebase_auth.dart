import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthentication implements AuthCredential {
  final firebaseAuth = FirebaseAuth.instance;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
