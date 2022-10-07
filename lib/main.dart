import 'package:atvee/screens/user/login_screen.dart';
import 'package:atvee/themes/routes.dart';
// import 'package:atvee/screens/opening/opening_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ATVEE',
      routes: AppRoutes.define(),
      home: LoginScreen(),
    );
  }
}
