import 'package:atvee/frontend/themes/string_extensions.dart';
import 'package:flutter/material.dart';

class RepasswordField extends StatefulWidget {
  const RepasswordField({super.key, required this.controller});
  final TextEditingController controller;

  @override
  State<StatefulWidget> createState() => _EmailFieldState();
}

class _EmailFieldState extends State<RepasswordField> {
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: (input) =>
          input!.hasLength(6, 18) ? null : "Mínimo 6, máximo 18 caracteres",
      obscureText: obscurePassword,
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
        labelText: "Senha Novamente",
        helperText: "",
        suffixIcon: IconButton(
          onPressed: () => setState(() {
            obscurePassword = !obscurePassword;
          }),
          icon: Icon(!obscurePassword ? Icons.visibility : Icons.visibility_off,
              color: Theme.of(context).primaryColor),
        ),
      ),
    );
  }
}
