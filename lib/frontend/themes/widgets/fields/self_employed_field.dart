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
            padding: EdgeInsets.only(left: width / 20),
            child: const Text('Profissional Autônomo?',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: EdgeInsets.only(left: width / 30),
            child: ListTile(
              title: const Text('Sim', style: TextStyle(color: Colors.white)),
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
            padding: EdgeInsets.only(left: width / 30),
            child: ListTile(
              title: const Text('Não', style: TextStyle(color: Colors.white)),
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
