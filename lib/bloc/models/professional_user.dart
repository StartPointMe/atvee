import 'package:cloud_firestore/cloud_firestore.dart';

class ProfessionalUser {
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String profilePicUrl;
  final bool isClient;

  const ProfessionalUser(this.firstName, this.lastName, this.email,
      this.phoneNumber, this.profilePicUrl, this.isClient);

  factory ProfessionalUser.fromDocument(QueryDocumentSnapshot document) {
    return ProfessionalUser(
        document['firstName'],
        document['lastName'],
        document['email'],
        document['phoneNumber'],
        document['profilePicUrl'],
        document['isCLient']);
  }
}
