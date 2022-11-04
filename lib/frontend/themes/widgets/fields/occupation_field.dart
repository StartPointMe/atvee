import 'package:atvee/backend/models/occupation.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class OccupationField extends StatefulWidget {
  const OccupationField({super.key, required this.controller});
  final TextEditingController controller;

  @override
  State<StatefulWidget> createState() => _OccupationFieldState();
}

class _OccupationFieldState extends State<OccupationField> {
  final List<String> occupations = Occupation().getOccupations();
  String? selectedOccupation;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        buttonWidth: MediaQuery.of(context).size.width / 1.3,
        buttonDecoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        hint: Padding(
          padding:
              EdgeInsets.only(left: MediaQuery.of(context).size.width / 20),
          child: Text(
            'Selecione uma profisssão',
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ),
        items: occupations
            .map((occupation) => DropdownMenuItem<String>(
                value: occupation.toString(),
                child: Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 20),
                  child: Text(
                    occupation.toString(),
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                )))
            .toList(),
        value: selectedOccupation,
        onChanged: (value) {
          setState(() {
            selectedOccupation = value;
            widget.controller.text = selectedOccupation as String;
          });
        },
      ),
    );
  }
}
