import 'package:flutter/material.dart';

class CustomWidget {
  // ignore: prefer_typing_uninitialized_variables, unused_field
  final _mediaQuery;

  CustomWidget(this._mediaQuery);

  Widget _createLabel(String fieldLabel, Color labelColor) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(fieldLabel,
          style: TextStyle(color: labelColor, fontWeight: FontWeight.bold)),
    );
  }

  Widget _createField(
    TextEditingController fieldController,
    String hint,
    bool isPassword,
  ) {
    return Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: SizedBox(
            width: _mediaQuery.size.width / 1.5,
            child: TextFormField(
              obscureText: isPassword,
              controller: fieldController,
              style: TextStyle(
                  fontSize: _mediaQuery.size.width / 24, color: Colors.black),
              cursorColor: Colors.black,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: hint,
                  hintStyle: TextStyle(
                      fontSize: _mediaQuery.size.width / 24,
                      color: Colors.black)),
            ),
          ),
        ));
  }

  void showSnack(BuildContext context, String error) {
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
      String fieldLabel, String hint, Color labelColor) {
    return Column(
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(
                left: _mediaQuery.size.width / 15,
                bottom: _mediaQuery.size.height / 120),
            child: _createLabel(fieldLabel, labelColor)),
        _createField(fieldController, hint, false)
      ],
    );
  }

  Widget createPasswordFieldWithLabel(TextEditingController fieldController,
      String fieldLabel, String hint, Color labelColor) {
    return Column(
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(
                left: _mediaQuery.size.width / 15,
                bottom: _mediaQuery.size.height / 120),
            child: _createLabel(fieldLabel, labelColor)),
        _createField(fieldController, hint, true)
      ],
    );
  }

  Widget buildUserAvatar(var imageURL, width, height) {
    //   if (imageURL == null || imageURL == "") {
    //     return Material(
    //         color: Colors.transparent,
    //         child: ClipOval(
    //           child: Image.asset(
    //             "lib/resources/icon-atvee.jpeg",
    //             width: width,
    //             height: height,
    //             fit: BoxFit.cover,
    //           ),
    //         ));
    //   } else {
    //     return Material(
    //         color: Colors.transparent,
    //         child: ClipOval(
    //           child: Image.network(
    //             imageURL,
    //             width: width,
    //             height: height,
    //             fit: BoxFit.cover,
    //           ),
    //         ));
    //   }
    // }
    return Material(
        color: Colors.transparent,
        child: ClipOval(
          child: Image.file(
            imageURL,
            width: width,
            height: height,
            fit: BoxFit.cover,
          ),
        ));
  }
}
