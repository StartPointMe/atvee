import 'package:cloud_firestore/cloud_firestore.dart';

class Address {
  final String userEmail;
  final Map<String, String> serviceAddresses;

  const Address(this.userEmail, this.serviceAddresses);

  factory Address.fromDocument(DocumentSnapshot document) {
    return Address(document['userEmail'], document['serviceAddresses']);
  }
}
