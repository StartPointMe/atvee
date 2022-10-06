import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../themes/routes.dart';

class OpeningScreen extends StatefulWidget {
  @override
  _OpeningViewState createState() => _OpeningViewState();
}

class _OpeningViewState extends State<OpeningScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: const Scaffold(
          backgroundColor: Colors.amberAccent,
          body: Text('ATVEE'),
        ));
  }
}
