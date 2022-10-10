import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomWidget {
  // ignore: prefer_typing_uninitialized_variables, unused_field
  final _mediaQuery;

  CustomWidget(this._mediaQuery);

  Widget _createLabel(String fieldLabel, Color labelColor) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(fieldLabel, style: TextStyle(color: labelColor)),
    );
  }

  Widget _createField(
    TextEditingController fieldController,
    bool isPassword,
  ) {
    return Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: SizedBox(
            width: _mediaQuery.size.width / 1.4,
            child: TextFormField(
              obscureText: isPassword,
              controller: fieldController,
              style: GoogleFonts.anton(
                  fontSize: _mediaQuery.size.width / 24, color: Colors.black),
              cursorColor: Colors.black,
              decoration: const InputDecoration(border: InputBorder.none),
            ),
          ),
        ));
  }

  void showErrorSnack(BuildContext context, String error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(error),
      ),
    );
  }

  Widget createImage(
      BuildContext context, String imagePath, double height, double width) {
    return Material(
      color: Colors.transparent,
      child: Image.asset(
        imagePath,
        height: _mediaQuery.size.height / height,
        width: _mediaQuery.size.width / width,
      ),
    );
  }

  Widget createTextFieldWithLabel(TextEditingController fieldController,
      String fieldLabel, Color labelColor) {
    return Column(
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(
                left: _mediaQuery.size.width / 15,
                bottom: _mediaQuery.size.height / 120),
            child: _createLabel(fieldLabel, labelColor)),
        _createField(fieldController, false)
      ],
    );
  }

  Widget createPasswordFieldWithLabel(TextEditingController fieldController,
      String fieldLabel, Color labelColor) {
    return Column(
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(
                left: _mediaQuery.size.width / 15,
                bottom: _mediaQuery.size.height / 120),
            child: _createLabel(fieldLabel, labelColor)),
        _createField(fieldController, true)
      ],
    );
  }
}
