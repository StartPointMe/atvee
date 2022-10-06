import 'package:flutter/cupertino.dart';
import 'package:atvee/screens/opening/opening_screen.dart';

class AppRoutes {
  AppRoutes._();

  static const String opening = '/opening';
  static const String login = '/login';

  static Map<String, WidgetBuilder> define() {
    return {
      opening: (context) => OpeningScreen(),
      // login:(context) => LoginScreen();
    };
  }
}
