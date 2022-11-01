import 'package:atvee/backend/models/activity.dart';
import 'package:atvee/backend/models/professional_user.dart';
import 'package:atvee/backend/repository/firebase/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfessionalService {
  FirebaseAuthentication firebaseAuth = FirebaseAuthentication();
  CollectionReference userdata =
      FirebaseFirestore.instance.collection('professionals');

  ProfessionalUser? professionalUser;

  List<String> saveActivities(List<Activity> activities) {
    List<String> selection = [];

    for (var activity in activities) {
      if (activity.isChecked == true) {
        selection.add(activity.value);
      }
    }

    if (selection.length > 3 || selection.isEmpty) {
      return [];
    } else {
      return selection;
    }
  }

  Future createData(ProfessionalUser user) async {
    try {
      await userdata.doc(user.email).set({
        'first_name': user.firstName,
        'last_name': user.lastName,
        'phone_number': user.phoneNumber,
        'profile_picture_url': user.profilePicUrl,
        'is_client': user.isClient,
        'is_self_employed': user.isSelfEmployed,
        'occupation': user.occupation,
        'description': user.description,
        'area_of_operation': user.areaOfOperation,
        'activities': user.activities
      });
    } catch (error) {}
  }

  Future createCredential(String email, String password) async {
    try {
      await firebaseAuth.registerUser(email, password);
    } on FirebaseAuthException catch (error) {
      return "${error.message}";
    }
  }

  Future redefinePassword(String email) async {
    firebaseAuth.resetPassword(email);
  }

  Future<String> signIn(String email, String password) async {
    User? user = await FirebaseAuthentication().signIn(email, password);

    if (user!.emailVerified) {
      return "ok";
    } else {
      return "fail";
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getProfessionals() {
    return FirebaseFirestore.instance.collection('professionals').snapshots();
  }
}
