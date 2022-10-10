import 'package:atvee/themes/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterScreen extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _RegisterScreenViewState createState() => _RegisterScreenViewState();
}

class _RegisterScreenViewState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final height = mediaQuery.size.height;
    final width = mediaQuery.size.width;

    CustomWidget customWidget = CustomWidget(mediaQuery);

    final fields = SizedBox(
      width: width / 1.2,
      child: Column(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(bottom: height / 30),
              child: customWidget.createTextFieldWithLabel(
                  _firstNameController, "Primeiro Nome", Colors.white)),
          Padding(
              padding: EdgeInsets.only(bottom: height / 30),
              child: customWidget.createTextFieldWithLabel(
                  _lastNameController, "Último Nome", Colors.white)),
          Padding(
              padding: EdgeInsets.only(bottom: height / 30),
              child: customWidget.createTextFieldWithLabel(
                  _phoneNumberController, "Número de Telefone", Colors.white)),
          Padding(
              padding: EdgeInsets.only(bottom: height / 30),
              child: customWidget.createTextFieldWithLabel(
                  _emailController, "E-mail", Colors.white)),
          Padding(
              padding: EdgeInsets.only(bottom: height / 30),
              child: customWidget.createPasswordFieldWithLabel(
                  _passwordController, "Senha", Colors.white)),
          Padding(
              padding: EdgeInsets.only(bottom: height / 30),
              child: customWidget.createPasswordFieldWithLabel(
                  _repasswordController, "Senha novamente", Colors.white))
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
          customWidget.showErrorSnack(context, "cadastro");
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [fields, registerButton],
              )
            ],
          ),
        ),
      ),
    );
  }
}
