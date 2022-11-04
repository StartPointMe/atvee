import 'dart:math';

import 'package:atvee/backend/service/professional_service.dart';
import 'package:atvee/frontend/themes/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProfessionalsList extends StatefulWidget {
  const ProfessionalsList({super.key});

  @override
  State<StatefulWidget> createState() => _ProfessionalsListState();
}

class _ProfessionalsListState extends State<ProfessionalsList> {
  ProfessionalService professionalService = ProfessionalService();

  late double width;
  late double height;
  late double buttonWidth;

  @override
  Widget build(BuildContext context) {
    Utils utils = Utils(context: context);
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    buttonWidth = width / 1.125;

    return StreamBuilder(
        stream: professionalService.getProfessionals(),
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
                      utils.professionalDialog(
                          document['profile_picture_url'],
                          document['first_name'] + " " + document['last_name'],
                          document['description'],
                          document['occupation'],
                          document['area_of_operation'],
                          document['is_self_employed']);
                    },
                    style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all<Size>(
                          Size(buttonWidth, 110)),
                    ),
                    child: SizedBox(
                      width: width / 1.2,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            utils.userClip(document['profile_picture_url'],
                                document['is_self_employed']),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    userInformation(
                                        document['first_name'] + " "),
                                    userInformation(
                                        document['last_name'] + " "),
                                  ],
                                ),
                                Row(
                                  children: [
                                    userInformation(
                                        document['occupation'].toUpperCase())
                                  ],
                                ),
                                Row(
                                  children: [
                                    userInformation(
                                        document['area_of_operation'])
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.star,
                                    color: Colors.amber.shade400,
                                    size: width / 8),
                                Text(
                                    "${Random().nextInt(5)}.${Random().nextInt(10)}",
                                    style: TextStyle(
                                        color: Colors.amber.shade400,
                                        fontSize: width / 20,
                                        fontStyle: FontStyle.normal)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ));
            }).toList(),
          );
        });
  }

  Widget userInformation(String text) => Text(
        text,
        style: Theme.of(context).textTheme.bodyText1,
      );
}
