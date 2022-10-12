// ignore_for_file: constant_identifier_names
import 'package:atvee/screens/home/home_screen.dart';
import 'package:atvee/screens/user/redefine_password_screen.dart';
import 'package:atvee/screens/user/register_cities_screen.dart';
import 'package:atvee/screens/user/register_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:atvee/screens/opening/opening_screen.dart';

import '../screens/user/login_screen.dart';

class AppRoutes {
  AppRoutes._();

  static const String opening = '/opening';
  static const String user_login = '/login';
  static const String user_register = '/register';
  static const String user_redefine_password = '/redefine_password';
  static const String user_register_cities = '/register_cities';
  static const String home = '/home';

  static Map<String, WidgetBuilder> define() {
    return {
      opening: (context) => OpeningScreen(),
      user_login: (context) => LoginScreen(),
      user_register: (context) => RegisterScreen(),
      user_redefine_password: (context) => RedefinePasswordScreen(),
      user_register_cities: (context) => RegisterCitiesScreen(),
      home: (context) => HomeScreen(),
    };
  }
}
