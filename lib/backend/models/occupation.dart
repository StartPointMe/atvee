class Occupation {
  static String get personal => "Personal Trainer";
  static String get nutricionista => "Nutricionista";
  static String get fisioterapeuta => "Fisioterapeuta";

  List<String> getOccupations() {
    return [personal, nutricionista, fisioterapeuta];
  }
}
