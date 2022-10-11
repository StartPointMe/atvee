// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:atvee/bloc/models/professional_user.dart';
import 'package:atvee/themes/custom_widget.dart';
import 'package:atvee/themes/routes.dart';
import 'package:atvee/themes/validation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  ProfessionalUser? _professionalUser;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final height = mediaQuery.size.height;
    final width = mediaQuery.size.width;

    CustomWidget customWidget = CustomWidget(mediaQuery);
    Validation validation = Validation();

    void _registerUser(ProfessionalUser professionalUser) async {
      try {
        CollectionReference userdata =
            FirebaseFirestore.instance.collection('professionals');
        await userdata.doc(professionalUser.email).set({
          'first_name': professionalUser.firstName,
          'last_name': professionalUser.lastName,
          'phone_number': professionalUser.phoneNumber,
          'image_url': '',
          'is_client': professionalUser.isClient
        }).then((value) => {
              customWidget.showSnack(context, "Por favor veri"),
              Future.delayed(const Duration(seconds: 2), () {
                Navigator.of(context).pushNamed(AppRoutes.user_login);
              })
            });
      } catch (error) {
        customWidget.showSnack(context, error.toString());
      }
    }

    void _createCredential(ProfessionalUser professionalUser) async {
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: professionalUser.email,
                password: _passwordController.text)
            .then((value) => {
                  customWidget.showSnack(context,
                      "Conta criada com Sucesso! Verifique o seu email para obter acesso."),
                  Future.delayed(const Duration(seconds: 2), () {
                    _registerUser(professionalUser);
                  })
                });
      } on FirebaseAuthException catch (error) {
        customWidget.showSnack(context, error.message.toString());
      }
    }

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
                  _phoneNumberController, "Número de Celular", Colors.white)),
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
          _professionalUser = ProfessionalUser(
              _firstNameController.text,
              _lastNameController.text,
              _emailController.text,
              _phoneNumberController.text,
              '',
              false);

          if (!validation.validEmail(_emailController.text)) {
            customWidget.showSnack(context, "Email inválido");
          } else if (!validation
              .validPhoneNumber(_phoneNumberController.text)) {
            customWidget.showSnack(context, "Número de celular inválido");
          } else if (_passwordController.text.length < 6) {
            customWidget.showSnack(context, "Minímo 6 caracteres");
          } else if (_passwordController.text != _repasswordController.text) {
            customWidget.showSnack(context, "Senhas diferentes");
          } else {
            _createCredential(_professionalUser!);
          }
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
          child: SingleChildScrollView(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                        padding: EdgeInsets.only(
                            top: height / 15, bottom: height / 20),
                        child: fields),
                    registerButton
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
