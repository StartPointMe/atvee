import 'package:atvee/frontend/themes/string_extensions.dart';
import 'package:flutter/material.dart';

class LastNameField extends StatefulWidget {
  const LastNameField({super.key, required this.controller});
  final TextEditingController controller;

  @override
  State<StatefulWidget> createState() => _LastNameFieldState();
}

class _LastNameFieldState extends State<LastNameField> {
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
        labelText: "Sobrenome",
        hintText: "Insira o seu sobrenome",
      ),
    );
  }
}
