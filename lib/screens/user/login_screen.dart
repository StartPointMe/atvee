import 'package:atvee/repository/firebase/firebase_auth.dart';
import 'package:atvee/themes/utils.dart';
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
    Utils utils = Utils(mediaQuery);
    FirebaseAuthentication firebaseAuth = FirebaseAuthentication();

    final appIcon = utils.createImage(context, "lib/resources/icon-atvee.jpeg");
    final emailField = utils.createField(_emailController);
    final passwordField = utils.createField(_passwordController);

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
        Text(
          "Email",
          style: GoogleFonts.roboto(
              fontSize: width / 24,
              color: Colors.white,
              fontWeight: FontWeight.bold),
        ),
        emailField,
        Padding(padding: EdgeInsets.only(top: height / 30)),
        Text(
          "Senha",
          style: GoogleFonts.roboto(
              fontSize: width / 24,
              color: Colors.white,
              fontWeight: FontWeight.bold),
        ),
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
          // final user = firebaseAuth.signIn(
          //     _emailController.text, _passwordController.text);
          utils.showErrorSnack(context, "login");
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

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Form(
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
                            bottom: height / 20, top: height / 20),
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
