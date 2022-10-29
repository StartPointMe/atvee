import 'package:flutter/material.dart';

List<String> cities = <String>[
  "Sorocaba",
  "Votorantim",
  "Salto de Pirapora",
  "Araçoiaba da Serra",
  "Iperó",
  "Porto Feliz",
  "Itu",
  "Mairinque",
  "Alumínio"
];

class CitySelector extends StatefulWidget {
  const CitySelector({super.key});

  @override
  State<CitySelector> createState() => _CitySelectorState();
}

class _CitySelectorState extends State<CitySelector> {
  String dropDownValue = cities.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropDownValue,
      icon: const Icon(Icons.arrow_drop_down),
      elevation: 16,
      style: const TextStyle(color: Colors.black),
      underline: Container(
        height: 3,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? value) {
        setState(() {
          dropDownValue = value!;
        });
      },
      items: cities.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
