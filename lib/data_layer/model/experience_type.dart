enum ExperienceType {
  internship,
  junior,
  middle,
  senior,
  director,
  seniorDirector
}

ExperienceType experienceTypeFromJson(String str) {
  ExperienceType type;

  if (str == "junior") {
    type = ExperienceType.junior;
  } else if (str == "middle") {
    type = ExperienceType.middle;
  } else if (str == "senior") {
    type = ExperienceType.senior;
  } else if (str == "director") {
    type = ExperienceType.director;
  } else if (str == "senior-director") {
    type = ExperienceType.seniorDirector;
  } else {
    type = ExperienceType.internship;
  }

  return type;
}

String experienceTypeToJson(ExperienceType type) {
  String str;

  if (type == ExperienceType.junior) {
    str = "junior";
  } else if (type == ExperienceType.middle) {
    str = "middle";
  } else if (type == ExperienceType.senior) {
    str = "senior";
  } else if (type == ExperienceType.director) {
    str = "director";
  } else if (type == ExperienceType.seniorDirector) {
    str = "senior-director";
  } else {
    str = "internship";
  }

  return str;
}
