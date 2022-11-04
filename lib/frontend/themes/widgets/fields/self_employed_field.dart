import 'package:atvee/frontend/themes/utils.dart';
import 'package:flutter/material.dart';

class SelfEmployedField extends StatefulWidget {
  const SelfEmployedField({super.key, required this.controller});
  final TextEditingController controller;

  @override
  State<StatefulWidget> createState() => _SelfEmployedFieldState();
}

class _SelfEmployedFieldState extends State<SelfEmployedField> {
  bool? isSelfEmployed;
  late double width;
  late double height;

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    widget.controller.text = "";

    setState(() {
      if (isSelfEmployed == true) {
        widget.controller.text = "sim";
      } else if (isSelfEmployed == false) {
        widget.controller.text = "não";
      }
    });

    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: width / 30),
            child: Text('Profissional Autônomo?',
                style: appTheme.textTheme.subtitle2),
          ),
          Padding(
            padding: EdgeInsets.only(left: width / 30),
            child: ListTile(
              tileColor: appTheme.primaryColor,
              title: Text('Sim', style: appTheme.textTheme.subtitle1),
              leading: Radio(
                fillColor: MaterialStateProperty.all(Colors.white),
                value: true,
                groupValue: isSelfEmployed,
                onChanged: (value) {
                  setState(() {
                    isSelfEmployed = value;
                  });
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: height / 240, left: width / 30),
            child: ListTile(
              tileColor: appTheme.primaryColor,
              title: Text('Não', style: appTheme.textTheme.subtitle1),
              leading: Radio(
                fillColor: MaterialStateProperty.all(Colors.white),
                value: false,
                groupValue: isSelfEmployed,
                onChanged: (value) {
                  setState(() {
                    isSelfEmployed = value;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
