import 'package:atvee/frontend/themes/string_extensions.dart';
import 'package:flutter/material.dart';

class DescriptionField extends StatefulWidget {
  const DescriptionField({super.key, required this.controller});
  final TextEditingController controller;

  @override
  State<StatefulWidget> createState() => _EmailFieldState();
}

class _EmailFieldState extends State<DescriptionField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: (input) =>
          input!.hasLength(10, 250) ? null : "Insira de 10 à 250 caracteres",
      keyboardType: TextInputType.multiline,
      maxLines: 5,
      decoration: const InputDecoration(
        labelText: "Descrição",
        hintText: "Insira uma descrição",
      ),
      style: Theme.of(context).textTheme.bodyText2,
    );
  }
}
