enum LanguageProficiency { a1, a2, b1, b2, c1, c2 }

LanguageProficiency languageProficiencyFromJson(String str) {
  LanguageProficiency proficiency;

  if (str == "A2") {
    proficiency = LanguageProficiency.a2;
  } else if (str == "B1") {
    proficiency = LanguageProficiency.b1;
  } else if (str == "B2") {
    proficiency = LanguageProficiency.b2;
  } else if (str == "C1") {
    proficiency = LanguageProficiency.c1;
  } else if (str == "C2") {
    proficiency = LanguageProficiency.c2;
  } else {
    proficiency = LanguageProficiency.a1;
  }

  return proficiency;
}

String languageProficiencyToJson(LanguageProficiency proficiency) {
  String str;

  if (proficiency == LanguageProficiency.a2) {
    str = "A2";
  } else if (proficiency == LanguageProficiency.b1) {
    str = "B1";
  } else if (proficiency == LanguageProficiency.b2) {
    str = "B2";
  } else if (proficiency == LanguageProficiency.c1) {
    str = "C1";
  } else if (proficiency == LanguageProficiency.c2) {
    str = "C2";
  } else {
    str = "A1";
  }

  return str;
}
