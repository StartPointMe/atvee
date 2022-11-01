import 'package:atvee/frontend/themes/widgets/professionals_list.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    var height = mediaQuery.size.height;

    const professionalsList = ProfessionalsList();

    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Profissionais"),
          centerTitle: true,
          backgroundColor: Colors.lightGreen,
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.only(bottom: height / 20, top: height / 20),
                    child: professionalsList,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
