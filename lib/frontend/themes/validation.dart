import 'package:email_validator/email_validator.dart';

class Validation {
  bool validPhoneNumber(String phoneNumber) {
    RegExp regExp = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');
    if (phoneNumber.isEmpty || !regExp.hasMatch(phoneNumber)) {
      return false;
    }
    return true;
  }

  bool validEmail(String userEmail) {
    bool isValid = EmailValidator.validate(userEmail);
    return isValid;
  }

  bool validTextLength(String text, int min, int max) {
    if (text.length < min || text.length > max) {
      return false;
    }
    return true;
  }

  bool hasNoSpace(String text) {
    if (text.trim() == "") {
      return false;
    }
    return true;
  }
}
