import 'package:atvee/bloc/models/regular_user.dart';
import 'package:atvee/themes/custom_widget.dart';
import 'package:atvee/themes/validation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

  RegularUser? _regularUser;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final height = mediaQuery.size.height;
    final width = mediaQuery.size.width;

    CustomWidget customWidget = CustomWidget(mediaQuery);
    Validation validation = Validation();

    void registerUser(RegularUser regularUser) async {
      try {
        String emailId = regularUser.email;
        CollectionReference userdata =
            FirebaseFirestore.instance.collection('userdata');
        await userdata.doc(emailId).set({
          'first_name': regularUser.firstName,
          'last_name': regularUser.lastName,
          'phone_number': regularUser.phoneNumber,
          'image_url': '',
        });

        // ignore: use_build_context_synchronously
        customWidget.showErrorSnack(context, emailId);
      } catch (error) {
        customWidget.showErrorSnack(context, error.toString());
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
          _regularUser = RegularUser(
              _firstNameController.text,
              _lastNameController.text,
              '',
              _emailController.text,
              _phoneNumberController.text,
              '');

          if (!validation.validEmail(_emailController.text)) {
            customWidget.showErrorSnack(context, "Email inválido");
          } else if (!validation
              .validPhoneNumber(_phoneNumberController.text)) {
            customWidget.showErrorSnack(context, "Número de celular inválido");
          } else {
            registerUser(_regularUser!);
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
                  children: [fields, registerButton],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
