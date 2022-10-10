import 'package:atvee/themes/routes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Utils {
  // ignore: prefer_typing_uninitialized_variables
  final mediaQuery;

  Utils(this.mediaQuery);

  void showErrorSnack(BuildContext context, String error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(error),
      ),
    );
  }

  Widget createImage(BuildContext context, String imagePath) {
    return Material(
      color: Colors.transparent,
      child: Image.asset(
        imagePath,
        height: mediaQuery.size.height / 4,
        width: mediaQuery.size.width / 1.5,
      ),
    );
  }

  Widget createField(TextEditingController fieldController) {
    return Material(
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: SizedBox(
            width: mediaQuery.size.width / 1.4,
            child: TextFormField(
              controller: fieldController,
              style: GoogleFonts.anton(
                  fontSize: mediaQuery.size.width / 24, color: Colors.black),
              cursorColor: Colors.black,
              decoration: const InputDecoration(border: InputBorder.none),
            ),
          ),
        ));
  }

  Widget createLabel(String label) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(label),
    );
  }

  Widget createLabelAndField(
      TextEditingController fieldController, String fieldLabel) {
    return Column(
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(
                left: mediaQuery.size.width / 15,
                bottom: mediaQuery.size.height / 120),
            child: createLabel(fieldLabel)),
        createField(fieldController)
      ],
    );
  }
}
