import 'package:atvee/themes/custom_widget.dart';
import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class HomeScreen extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenViewState createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    var height = mediaQuery.size.height;

    CustomWidget customWidget = CustomWidget(mediaQuery);

    final appIcon = customWidget.createImage(
        context, "lib/resources/icon-atvee.jpeg", 4, 1.5);

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: height / 20, top: height / 20),
                        child: appIcon,
                      ),
                    ],
                  )
                ],
              ),
            )),
      ),
    );
  }
}
