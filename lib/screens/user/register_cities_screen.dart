// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, unused_local_variable, avoid_function_literals_in_foreach_calls

import 'package:atvee/bloc/models/city.dart';
import 'package:atvee/themes/city_checkbox.dart';
import 'package:atvee/themes/custom_widget.dart';
import 'package:atvee/themes/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterCitiesScreen extends StatefulWidget {
  @override
  _RegisterCitiesViewState createState() => _RegisterCitiesViewState();
}

class _RegisterCitiesViewState extends State<RegisterCitiesScreen> {
  final List<City> cities = [
    City(name: "Sorocaba"),
    City(name: "Votorantim"),
    City(name: "Salto de Pirapora"),
    City(name: "Araçoiaba da Serra"),
    City(name: "Iperó"),
    City(name: "Porto Feliz"),
    City(name: "Itu"),
    City(name: "Mairinque"),
    City(name: "Alumínio"),
  ];

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final width = mediaQuery.size.width;
    final height = mediaQuery.size.height;

    CustomWidget customWidget = CustomWidget(mediaQuery);

    void saveCities(List<City> cities) async {
      final selection = [];
      for (var c in cities) {
        if (c.check == true) {
          selection.add(c.name);
        }
      }

      User? user = FirebaseAuth.instance.currentUser;
      String emailId = user!.email.toString();

      CollectionReference userdata =
          FirebaseFirestore.instance.collection('professionals');

      await userdata.doc(emailId).update({'cities': selection});

      user.sendEmailVerification();
      FirebaseAuth.instance.signOut();
    }

    final citiesList = Column(
      children: <Widget>[
        CityCheckboxWidget(item: cities[0]),
        CityCheckboxWidget(item: cities[1]),
        CityCheckboxWidget(item: cities[2]),
        CityCheckboxWidget(item: cities[3]),
        CityCheckboxWidget(item: cities[4]),
        CityCheckboxWidget(item: cities[5]),
        CityCheckboxWidget(item: cities[6]),
        CityCheckboxWidget(item: cities[7]),
        CityCheckboxWidget(item: cities[8]),
      ],
    );

    final completeRegisterButton = ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Color(0xffFF8A00)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ))),
        onPressed: () {
          saveCities(cities);
          customWidget.showSnack(context, "Email de verificação enviado");
          Future.delayed(const Duration(seconds: 2), () {
            Navigator.of(context).pushReplacementNamed(AppRoutes.user_login);
          });
          //temp user profile
        },
        child: Padding(
            padding: EdgeInsets.fromLTRB(
                width / 25, height / 150, width / 25, height / 150),
            child: Text(
              "completar cadastro".toUpperCase(),
              style:
                  GoogleFonts.anton(fontSize: width / 14, color: Colors.black),
            )));

    final citiesContainer = Container(
      width: mediaQuery.size.width / 1.2,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Column(children: <Widget>[
        Padding(
            padding: EdgeInsets.only(
                top: mediaQuery.size.height / 12,
                bottom: mediaQuery.size.width / 12),
            child: citiesList),
        Padding(
            padding: EdgeInsets.only(top: height / 30, bottom: height / 30),
            child: completeRegisterButton),
      ]),
    );

    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
            backgroundColor: Color(0xffFF8A00),
            body: Form(
                child: SingleChildScrollView(
                    padding:
                        EdgeInsets.only(top: height / 12, bottom: height / 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [citiesContainer],
                    )))));
  }
}
