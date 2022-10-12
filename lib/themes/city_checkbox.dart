import 'package:atvee/bloc/models/city.dart';
import 'package:flutter/material.dart';

class CityCheckboxWidget extends StatefulWidget {
  final City item;

  const CityCheckboxWidget({Key? key, required this.item}) : super(key: key);

  @override
  _CityCheckboxWidgetState createState() => _CityCheckboxWidgetState();
}

class _CityCheckboxWidgetState extends State<CityCheckboxWidget> {
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(widget.item.name),
      value: widget.item.check,
      onChanged: (bool? value) {
        setState(() {
          widget.item.check = value;
        });
      },
    );
  }
}
