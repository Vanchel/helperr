enum EducationType {
  course,
  primary,
  basic,
  secondary,
  postSecondary,
  bachelor,
  specialist,
  magister,
  phdAsp,
  phdDoc
}

EducationType educationTypeFromJson(String str) {
  EducationType type;

  if (str == "primary") {
    type = EducationType.primary;
  } else if (str == "basic") {
    type = EducationType.basic;
  } else if (str == "secondary") {
    type = EducationType.secondary;
  } else if (str == "post-secondary") {
    type = EducationType.postSecondary;
  } else if (str == "bachelor") {
    type = EducationType.bachelor;
  } else if (str == "specialist") {
    type = EducationType.specialist;
  } else if (str == "master") {
    type = EducationType.magister;
  } else if (str == "PhD-asp") {
    type = EducationType.phdAsp;
  } else if (str == "PhD-doc") {
    type = EducationType.phdDoc;
  } else {
    type = EducationType.course;
  }

  return type;
}

String educationTypeToJson(EducationType type) {
  String str;

  if (type == EducationType.primary) {
    str = "primary";
  } else if (type == EducationType.basic) {
    str = "basic";
  } else if (type == EducationType.secondary) {
    str = "secondary";
  } else if (type == EducationType.postSecondary) {
    str = "post-secondary";
  } else if (type == EducationType.bachelor) {
    str = "bachelor";
  } else if (type == EducationType.magister) {
    str = "master";
  } else if (type == EducationType.phdAsp) {
    str = "PhD-asp";
  } else if (type == EducationType.phdDoc) {
    str = "PhD-doc";
  } else {
    str = "course";
  }

  return str;
}
