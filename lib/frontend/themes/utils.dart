import 'package:flutter/material.dart';

class Utils {
  Utils({required this.context});
  BuildContext context;

  void snack(String error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(error),
      ),
    );
  }

  Future alert(String message) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: SizedBox(
            child: Text(message, style: const TextStyle(color: Colors.black)),
          ),
        ),
      );

  Widget userClip(String userPicUrl, bool isSelfEmployed) => Container(
        width: MediaQuery.of(context).size.width / 5,
        color: Colors.transparent,
        child: isSelfEmployed == true
            ? ClipOval(
                child: Image.network(
                  userPicUrl,
                  width: MediaQuery.of(context).size.width / 5,
                  height: MediaQuery.of(context).size.height / 10,
                  fit: BoxFit.cover,
                ),
              )
            : ClipRRect(
                child: Image.network(
                  userPicUrl,
                  width: MediaQuery.of(context).size.width / 6,
                  height: MediaQuery.of(context).size.height / 12,
                  fit: BoxFit.cover,
                ),
              ),
      );

  Future professionalDialog(String userPic, String name, String description,
          String occupation, String area, bool selfEmployed) =>
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: SizedBox(
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                userClip(userPic, selfEmployed),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).primaryColor),
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: const TextStyle(color: Colors.white),
                          ),
                          Text(
                            occupation,
                            style: const TextStyle(color: Colors.white),
                          ),
                          Text(
                            area,
                            style: const TextStyle(color: Colors.white),
                          ),
                          selfEmployed == true
                              ? const Text("Profissional Autônomo\n",
                                  style: TextStyle(color: Colors.white))
                              : const Text(""),
                        ]
                            .map((widget) => Padding(
                                  padding:
                                      const EdgeInsets.only(top: 2, left: 15),
                                  child: widget,
                                ))
                            .toList(),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(description,
                      style:
                          const TextStyle(color: Colors.black, fontSize: 18)),
                ),
              ]
                  .map((widget) => Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: widget,
                      ))
                  .toList(),
            ),
          ),
        ),
      );
}
