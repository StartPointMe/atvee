import 'package:atvee/backend/service/professional_service.dart';
import 'package:atvee/frontend/themes/utils.dart';
import 'package:atvee/frontend/themes/routes.dart';
import 'package:atvee/frontend/themes/widgets/fields/email_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RedefinePasswordScreen extends StatefulWidget {
  const RedefinePasswordScreen({super.key});

  @override
  State<StatefulWidget> createState() => _RedefinePasswordScreenViewState();
}

class _RedefinePasswordScreenViewState extends State<RedefinePasswordScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  late Utils utils;
  ProfessionalService professionalService = ProfessionalService();

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    final height = mediaQuery.size.height;
    final width = mediaQuery.size.width;

    utils = Utils(context: context);

    final emailField = EmailField(controller: emailController);

    final fields = SizedBox(
      width: width / 1.2,
      child: Column(
        children: [
          Text(
              "Insira o endereço de e-mail que utilizou durante o cadastro, "
              "após verificarmos se o mesmo está cadastrado no sistema, enviaremos "
              "um email para que posssa redefinir a senha.",
              style: appTheme.textTheme.subtitle2),
          Padding(
            padding: EdgeInsets.only(top: height / 20, bottom: height / 40),
            child: emailField,
          )
        ],
      ),
    );

    final redefineButton = ElevatedButton(
        onPressed: () async {
          if (formKey.currentState!.validate()) {
            handleRedefinePassword();
            utils.alert("Enviando email, aguarde...");
            Future.delayed(const Duration(seconds: 3), () {
              Navigator.of(context).pushReplacementNamed(AppRoutes.user_login);
            });
          }
        },
        child: Text(
          "ENVIAR",
          style: appTheme.textTheme.button,
        ));

    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Redefinição de Senha"),
        ),
        backgroundColor: appTheme.backgroundColor,
        body: Form(
          key: formKey,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: height / 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [fields, redefineButton],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void handleRedefinePassword() async {
    try {
      await professionalService.redefinePassword(emailController.text);
    } catch (error) {
      utils.alert(
          "Erro ao enviar e-mail, verifique se os dados inserridos estão corretos");
    }
  }
}
