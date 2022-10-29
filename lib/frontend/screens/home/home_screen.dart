// ignore_for_file: library_private_types_in_public_api

import 'package:atvee/frontend/themes/custom_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenViewState createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    var width = mediaQuery.size.width;
    var height = mediaQuery.size.height;

    CustomWidget customWidget = CustomWidget(mediaQuery);

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Profissionais"),
          centerTitle: true,
          backgroundColor: Colors.lightGreen,
        ),
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
                        child: professionalsContainer(width, height),
                      ),
                    ],
                  )
                ],
              ),
            )),
      ),
    );
  }

  Widget professionalsContainer(width, height) => StreamBuilder(
      stream:
          FirebaseFirestore.instance.collection('professionals').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Column(
          children: snapshot.data!.docs.map((document) {
            return Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: ElevatedButton(
                  onPressed: () {
                    openDialog(
                        userClip(document['profile_picture_url'],
                            document['is_self_employed'], width, height),
                        document['first_name'] + " " + document['last_name'],
                        document['description']);
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
                  ),
                  child: SizedBox(
                    width: width / 1.2,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          userClip(document['profile_picture_url'],
                              document['is_self_employed'], width, height),
                          Padding(
                            padding: EdgeInsets.only(right: width / 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(document['first_name'] + " "),
                                    Text(document['last_name']),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(document['occupation'].toUpperCase())
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(document['area_of_operation'])
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: width / 40),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.star,
                                    color: Colors.amber.shade400,
                                    size: width / 8),
                                Text('5',
                                    style: TextStyle(
                                        color: Colors.amber.shade400,
                                        fontSize: width / 20)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ));
          }).toList(),
        );
      });

  Widget userClip(String userPicUrl, bool isSelfEmployed, width, height) =>
      Material(
        color: Colors.transparent,
        child: isSelfEmployed == true
            ? ClipOval(
                child: Image.network(
                  userPicUrl,
                  width: width / 5,
                  height: height / 10,
                  fit: BoxFit.cover,
                ),
              )
            : ClipRRect(
                child: Image.network(
                  userPicUrl,
                  width: width / 5,
                  height: height / 10,
                  fit: BoxFit.cover,
                ),
              ),
      );

  Future openDialog(Widget userPic, String name, String description) =>
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: SizedBox(
            height: 200,
            width: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                userPic,
                Text(name),
                Text(description),
              ],
            ),
          ),
        ),
      );
}
