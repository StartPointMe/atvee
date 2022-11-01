import 'package:atvee/frontend/themes/string_extensions.dart';
import 'package:flutter/material.dart';

class EmailField extends StatefulWidget {
  const EmailField({super.key, required this.controller});
  final TextEditingController controller;

  @override
  State<StatefulWidget> createState() => _EmailFieldState();
}

class _EmailFieldState extends State<EmailField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: (input) => input!.isValidEmail() ? null : "Email inválido",
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        labelText: "Endereço de email",
        hintText: "Insira o seu endereço de email",
      ),
    );
  }
}
