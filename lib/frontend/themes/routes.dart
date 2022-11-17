// ignore_for_file: constant_identifier_names
import 'package:atvee/frontend/screens/home/home_screen.dart';
import 'package:atvee/frontend/screens/user/redefine_password_screen.dart';
import 'package:atvee/frontend/screens/user/register_screen.dart';
import 'package:flutter/cupertino.dart';

import '../screens/user/login_screen.dart';

class AppRoutes {
  AppRoutes._();

  static const String user_login = '/login';
  static const String user_register = '/register';
  static const String user_redefine_password = '/redefine_password';
  static const String home = '/home';

  static Map<String, WidgetBuilder> define() {
    return {
      user_login: (context) => LoginScreen(),
      user_register: (context) => RegisterScreen(),
      user_redefine_password: (context) => RedefinePasswordScreen(),
      home: (context) => HomeScreen(),
    };
  }
}
