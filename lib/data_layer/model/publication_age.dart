enum PublicationAge {
  allTime,
  day,
  threeDays,
  week,
  twoWeeks,
  month,
}

PublicationAge publicationAgeFromJson(String str) {
  PublicationAge age;

  if (str == 'day') {
    age = PublicationAge.day;
  } else if (str == 'three-days') {
    age = PublicationAge.threeDays;
  } else if (str == 'week') {
    age = PublicationAge.week;
  } else if (str == 'two-weeks') {
    age = PublicationAge.twoWeeks;
  } else if (str == 'month') {
    age = PublicationAge.month;
  } else {
    age = PublicationAge.allTime;
  }

  return age;
}

String publicationAgeToJson(PublicationAge age) {
  String str;

  if (age == PublicationAge.day) {
    str = 'day';
  } else if (age == PublicationAge.threeDays) {
    str = 'three-days';
  } else if (age == PublicationAge.week) {
    str = 'week';
  } else if (age == PublicationAge.twoWeeks) {
    str = 'two-weeks';
  } else if (age == PublicationAge.month) {
    str = 'month';
  } else {
    str = 'all-time';
  }

  return str;
}
