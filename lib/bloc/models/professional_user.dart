import 'package:cloud_firestore/cloud_firestore.dart';

class ProfessionalUser {
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String profilePicUrl;
  final bool isClient;
  final String occupation;
  final String description;
  final String areaOfOperation;
  final List<String> activities;

  const ProfessionalUser(
      this.firstName,
      this.lastName,
      this.email,
      this.phoneNumber,
      this.profilePicUrl,
      this.isClient,
      this.occupation,
      this.description,
      this.areaOfOperation,
      this.activities);

  factory ProfessionalUser.fromDocument(QueryDocumentSnapshot document) {
    return ProfessionalUser(
        document['firstName'],
        document['lastName'],
        document['email'],
        document['phoneNumber'],
        document['profilePicUrl'],
        document['isCLient'],
        document['occupation'],
        document['description'],
        document['areaOfOperation'],
        document['activities']);
  }
}
