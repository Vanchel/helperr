enum UserType { employee, employer }

UserType userTypeFromJson(String str) {
  UserType type;

  if (str == 'employer') {
    type = UserType.employer;
  } else {
    type = UserType.employee;
  }

  return type;
}

String userTypeToJson(UserType type) {
  String str;

  if (type == UserType.employer) {
    str = 'employer';
  } else {
    str = 'employee';
  }

  return str;
}
