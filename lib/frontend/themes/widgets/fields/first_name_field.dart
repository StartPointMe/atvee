import 'package:atvee/frontend/themes/string_extensions.dart';
import 'package:flutter/material.dart';

class FirstNameField extends StatefulWidget {
  const FirstNameField({super.key, required this.controller});
  final TextEditingController controller;

  @override
  State<StatefulWidget> createState() => _FirstNameFieldState();
}

class _FirstNameFieldState extends State<FirstNameField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: (input) {
        if (input!.isEmpty || input.isWhitespace()) {
          return "Campo obrigatório";
        }
        if (input.hasNumber()) {
          return "Apenas letras";
        }
        if (input.hasSpace()) {
          return "Sem espaços em branco";
        }
      },
      keyboardType: TextInputType.name,
      decoration: const InputDecoration(
        labelText: "Nome",
        hintText: "Insira o seu nome",
      ),
    );
  }
}
