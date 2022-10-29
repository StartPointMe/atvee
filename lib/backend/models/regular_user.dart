import 'package:cloud_firestore/cloud_firestore.dart';

class RegularUser {
  final String firstName;
  final String lastName;
  final String gender;
  final String email;
  final String phoneNumber;
  final String profilePicUrl;

  const RegularUser(this.firstName, this.lastName, this.gender, this.email,
      this.phoneNumber, this.profilePicUrl);

  factory RegularUser.fromDocument(QueryDocumentSnapshot document) {
    return RegularUser(
        document['firstName'],
        document['lastName'],
        document['gender'],
        document['email'],
        document['phoneNumber'],
        document['profilePicUrl']);
  }

  @override
  String toString() {
    // TODO: implement toString
    return super.toString();
  }
}
