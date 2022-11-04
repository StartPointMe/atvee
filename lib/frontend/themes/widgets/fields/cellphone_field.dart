import 'package:atvee/frontend/themes/string_extensions.dart';
import 'package:flutter/material.dart';

class CellphoneField extends StatefulWidget {
  const CellphoneField({super.key, required this.controller});
  final TextEditingController controller;

  @override
  State<StatefulWidget> createState() => _CellphoneFieldState();
}

class _CellphoneFieldState extends State<CellphoneField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: (input) => input!.isValidPhone()
          ? null
          : "Número de inválido, insira de 10 à 12 números",
      keyboardType: TextInputType.phone,
      decoration: const InputDecoration(
        labelText: "Número de Celular",
        hintText: "Insira o seu número de celular",
      ),
      style: Theme.of(context).textTheme.bodyText2,
    );
  }
}
