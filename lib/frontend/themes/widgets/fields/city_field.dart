import 'package:atvee/backend/models/city.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class CityField extends StatefulWidget {
  const CityField({super.key, required this.controller});
  final TextEditingController controller;

  @override
  State<StatefulWidget> createState() => _CityFieldState();
}

class _CityFieldState extends State<CityField> {
  List<String> cities = City().getCities();
  String? selectedCity;

  @override
  Widget build(BuildContext context) {
    // setState(() {
    //   if (selectedCity.isNotEmpty) {
    //     // widget.controller.text = selectedCity;
    //     // alert(widget.controller.text);
    //   }
    // });

    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        buttonWidth: MediaQuery.of(context).size.width / 1.3,
        buttonDecoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        hint: Padding(
          padding:
              EdgeInsets.only(left: MediaQuery.of(context).size.width / 20),
          child: const Text(
            'Selecione uma cidade',
            style: TextStyle(fontSize: 14, color: Colors.black),
          ),
        ),
        items: cities
            .map((city) => DropdownMenuItem<String>(
                value: city,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 20),
                  child: Text(
                    city,
                    style: const TextStyle(fontSize: 14, color: Colors.black),
                  ),
                )))
            .toList(),
        value: selectedCity,
        onChanged: (value) {
          setState(() {
            selectedCity = value;
            widget.controller.text = selectedCity.toString();
          });
        },
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
}
