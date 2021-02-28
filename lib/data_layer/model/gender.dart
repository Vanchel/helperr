enum Gender { male, female, unknown }

Gender genderFromJson(String str) {
  Gender gender;

  if (str == "male") {
    gender = Gender.male;
  } else if (str == "female") {
    gender = Gender.female;
  } else {
    gender = Gender.unknown;
  }

  return gender;
}

String genderToJson(Gender gender) {
  String str;

  if (gender == Gender.male) {
    str = "male";
  } else if (gender == Gender.female) {
    str = "female";
  } else {
    str = "";
  }

  return str;
}
