import 'package:atvee/frontend/screens/user/login_screen.dart';
import 'package:atvee/frontend/themes/routes.dart';
import 'package:atvee/frontend/themes/my_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ATVEE',
      routes: AppRoutes.define(),
      home: const LoginScreen(),
      theme: MyTheme().appTheme(),
    );
  }
}
