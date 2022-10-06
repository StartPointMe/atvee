import 'package:atvee/routes.dart';
import 'package:atvee/views/OpeningScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ATVEE',
      routes: AppRoutes.define(),
      home: OpeningScreen(),
    );
  }
}
