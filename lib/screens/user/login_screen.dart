// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:atvee/themes/custom_widget.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../themes/routes.dart';

// ignore: use_key_in_widget_constructors
class LoginScreen extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenViewState createState() => _LoginScreenViewState();
}

class _LoginScreenViewState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    var height = mediaQuery.size.height;
    var width = mediaQuery.size.width;

    CustomWidget customWidget = CustomWidget(mediaQuery);

    Future _signIn(String email, String password) async {
      try {
        User? user = (await FirebaseAuth.instance
                .signInWithEmailAndPassword(email: email, password: password))
            .user;

        if (user!.emailVerified) {
          Navigator.of(context).pushNamed(AppRoutes.home);
        } else {
          customWidget.showSnack(context,
              "Por favor, verifique o seu e-mail antes de efetuar o login");
        }
      } on FirebaseAuthException catch (error) {
        customWidget.showSnack(context, error.message.toString());
      }
    }

    final appIcon = customWidget.createImage(
        context, "lib/resources/icon-atvee.jpeg", 4, 1.5);
    final emailField = customWidget.createTextFieldWithLabel(_emailController,
        "E-mail", "Insira o seu email de cadastro", Colors.white);
    final passwordField = customWidget.createPasswordFieldWithLabel(
        _passwordController, "Senha", "Insira a sua senha", Colors.white);

    final registerAnchor = MaterialButton(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onPressed: () {
          Navigator.of(context).pushNamed(AppRoutes.user_register);
        },
        child: Text(
          "Cadastre-se",
          style: GoogleFonts.roboto(
              fontSize: width / 24,
              color: Colors.white,
              fontWeight: FontWeight.bold),
        ));

    final forgetPasswordAnchor = MaterialButton(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onPressed: () {
          Navigator.of(context).pushNamed(AppRoutes.user_redefine_password);
        },
        child: Text(
          "Esqueceu a senha?",
          style: GoogleFonts.roboto(
              fontSize: width / 24,
              color: Colors.white,
              fontWeight: FontWeight.bold),
        ));

    final registerFields = Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(padding: EdgeInsets.only(top: height / 30)),
        emailField,
        Padding(padding: EdgeInsets.only(top: height / 30)),
        passwordField
      ],
    );

    final logInButton = ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
                const Color.fromARGB(255, 59, 82, 67)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ))),
        onPressed: () async {
          _signIn(_emailController.text, _passwordController.text);
        },
        child: Padding(
            padding: EdgeInsets.fromLTRB(
                width / 3.8, height / 100, width / 3.8, height / 100),
            child: Text(
              "entrar".toUpperCase(),
              style: GoogleFonts.anton(fontSize: 30, color: Colors.white),
            )));

    final fields = Container(
        width: width / 1.2,
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 59, 82, 67),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: height / 40),
              child: registerFields,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [registerAnchor, forgetPasswordAnchor],
            ),
          ],
        ));

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: height / 18,
      ),
      backgroundColor: Colors.white,
      body: DoubleBackToCloseApp(
        snackBar: const SnackBar(content: Text("Toque de novo para sair")),
        child: Form(
            key: _formKey,
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
}
