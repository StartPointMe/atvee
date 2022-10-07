import 'package:atvee/screens/user/register_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:atvee/screens/opening/opening_screen.dart';

import '../screens/user/login_screen.dart';

class AppRoutes {
  AppRoutes._();

  static const String opening = '/opening';
  static const String user_login = '/login';
  static const String user_register = '/register';

  static Map<String, WidgetBuilder> define() {
    return {
      opening: (context) => OpeningScreen(),
      user_login: (context) => LoginScreen(),
      user_register: (context) => RegisterScreen(),
    };
  }
}
