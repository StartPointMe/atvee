import 'package:atvee/backend/service/professional_service.dart';
import 'package:atvee/frontend/themes/utils.dart';
import 'package:atvee/frontend/themes/widgets/fields/email_field.dart';
import 'package:atvee/frontend/themes/widgets/fields/password_field.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../themes/routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => _LoginScreenViewState();
}

class _LoginScreenViewState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  late Utils utils;
  ProfessionalService professionalService = ProfessionalService();

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    var height = mediaQuery.size.height;
    var width = mediaQuery.size.width;

    utils = Utils(context: context);

    final appIcon = ClipRect(
        child: Image.asset(
      "lib/resources/icon-atvee.jpeg",
      width: width / 2,
      height: height / 4,
      fit: BoxFit.cover,
    ));
    final emailField = EmailField(controller: emailController);
    final passwordField = PasswordField(controller: passwordController);

    final registerAnchor = MaterialButton(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onPressed: () {
        Navigator.of(context).pushNamed(AppRoutes.user_register);
      },
      child: Text(
        "Cadastre-se",
        style: appTheme.textTheme.subtitle2,
      ),
    );

    final forgetPasswordAnchor = MaterialButton(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onPressed: () {
        Navigator.of(context).pushNamed(AppRoutes.user_redefine_password);
      },
      child: Text(
        "Esqueceu a senha?",
        style: appTheme.textTheme.subtitle2,
      ),
    );

    final logInButton = ElevatedButton(
      onPressed: () async {
        if (formKey.currentState!.validate()) {
          if (await handleLogin()) {
            utils.alert("Aguarde...");
            Future.delayed(const Duration(seconds: 5), () {
              Navigator.of(context).pushNamed(AppRoutes.home);
            });
          }
        }
      },
      child: Text(
        "ENTRAR",
        style: appTheme.textTheme.button,
      ),
    );

    final fields = SizedBox(
      width: width / 1.2,
      child: Column(
        children: <Widget>[
          emailField,
          passwordField,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [registerAnchor, forgetPasswordAnchor],
          ),
        ]
            .map((widget) => Padding(
                  padding: EdgeInsets.only(bottom: height / 40),
                  child: widget,
                ))
            .toList(),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      backgroundColor: Colors.white,
      body: DoubleBackToCloseApp(
        snackBar: const SnackBar(content: Text("Toque de novo para sair")),
        child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: height / 20, top: height / 35),
                        child: appIcon,
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: height / 20),
                        child: fields,
                      ),
                      logInButton
                    ],
                  )
                ],
              ),
            )),
      ),
    );
  }

  Future<bool> handleLogin() async {
    try {
      String verified = await professionalService.signIn(
          emailController.text, passwordController.text);

      if (verified == "ok") {
        return true;
      } else {
        utils.alert("Verifique a sua conta antes de efetuar o login");
        return false;
      }
    } catch (error) {
      utils.alert("Por favor, verifique se os dados inseridos estão corretos");
      return false;
    }
  }
}
