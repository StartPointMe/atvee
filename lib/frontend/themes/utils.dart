import 'package:flutter/material.dart';

class Utils {
  Utils({required this.context});
  BuildContext context;

  void snack(String error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(error),
      ),
    );
  }

  Future alert(String message) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: SizedBox(
            child: Text(message),
          ),
        ),
      );

  Future openDialog(Widget userPic, String name, String description) =>
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: SizedBox(
            height: 200,
            width: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                userPic,
                Text(name),
                Text(description),
              ],
            ),
          ),
        ),
      );
}
