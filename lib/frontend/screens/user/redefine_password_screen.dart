import 'package:atvee/frontend/themes/custom_widget.dart';
import 'package:atvee/frontend/themes/routes.dart';
import 'package:atvee/frontend/themes/validation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RedefinePasswordScreen extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _RedefinePasswordScreenViewState createState() =>
      _RedefinePasswordScreenViewState();
}

class _RedefinePasswordScreenViewState extends State<RedefinePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final height = mediaQuery.size.height;
    final width = mediaQuery.size.width;

    CustomWidget customWidget = CustomWidget(mediaQuery);

    Validation validation = Validation();

    final emailField = customWidget.createTextFieldWithLabel(_emailController,
        "E-mail", "Insira o seu email de cadastro", Colors.white);

    final fields = SizedBox(
      width: width,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: height / 40),
            child: emailField,
          )
        ],
      ),
    );

    final redefineButton = ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
                const Color.fromARGB(255, 59, 82, 67)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ))),
        onPressed: () async {
          if (validation.validEmail(_emailController.text)) {
            final auth = FirebaseAuth.instance
                .sendPasswordResetEmail(email: _emailController.text);
            customWidget.showSnack(
                context, "Email de redefinição de senha enviado");
            Future.delayed(const Duration(seconds: 3), () {
              Navigator.of(context).pushReplacementNamed(AppRoutes.user_login);
            });
          } else {
            customWidget.showSnack(context, "Insira um email válido");
          }
        },
        child: Padding(
            padding: EdgeInsets.fromLTRB(
                width / 10, height / 100, width / 10, height / 100),
            child: Text(
              "enviar".toUpperCase(),
              style: GoogleFonts.anton(fontSize: 30, color: Colors.white),
            )));

    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        backgroundColor: Colors.amber,
        body: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: height / 20),
                child: fields,
              ),
              redefineButton
            ],
          ),
        ),
      ),
    );
  }
}
