import 'package:atvee/themes/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterScreen extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _RegisterScreenViewState createState() => _RegisterScreenViewState();
}

class _RegisterScreenViewState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final height = mediaQuery.size.height;
    final width = mediaQuery.size.width;

    Utils utils = Utils(mediaQuery);

    final emailField = utils.createField(_emailController);
    final passwordField = utils.createField(_passwordController);

    final fields = SizedBox(
      width: width,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: height / 40),
            child: emailField,
          ),
          passwordField
        ],
      ),
    );

    final registerButton = ElevatedButton(
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
          utils.showErrorSnack(context, "cadastro");
        },
        child: Padding(
            padding: EdgeInsets.fromLTRB(
                width / 3.8, height / 100, width / 3.8, height / 100),
            child: Text(
              "cadastrar".toUpperCase(),
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
              registerButton
            ],
          ),
        ),
      ),
    );
  }
}
