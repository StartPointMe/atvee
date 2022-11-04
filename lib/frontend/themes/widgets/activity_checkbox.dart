import 'package:atvee/backend/models/activity.dart';
import 'package:flutter/material.dart';

class ActivityCheckboxWidget extends StatefulWidget {
  final Activity item;

  const ActivityCheckboxWidget({Key? key, required this.item})
      : super(key: key);

  @override
  _ActivityCheckboxWidgetState createState() => _ActivityCheckboxWidgetState();
}

class _ActivityCheckboxWidgetState extends State<ActivityCheckboxWidget> {
  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);

    return SizedBox(
        width: mediaQuery.size.width / 1.3,
        child: CheckboxListTile(
          checkColor: appTheme.primaryColorLight,
          activeColor: appTheme.backgroundColor,
          tileColor: appTheme.primaryColor,
          title: Text(
            widget.item.value,
            style: appTheme.textTheme.bodyText1,
          ),
          value: widget.item.isChecked,
          onChanged: (bool? value) {
            setState(() {
              widget.item.isChecked = value;
            });
          },
        ));
  }
}
