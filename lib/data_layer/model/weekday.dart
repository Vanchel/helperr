enum Weekday { monday, tuesday, wednesday, thursday, friday, saturday, sunday }

Weekday weekdayFromInt(int i) {
  Weekday day;

  if (i == 1) {
    day = Weekday.tuesday;
  } else if (i == 2) {
    day = Weekday.wednesday;
  } else if (i == 3) {
    day = Weekday.thursday;
  } else if (i == 4) {
    day = Weekday.friday;
  } else if (i == 5) {
    day = Weekday.saturday;
  } else if (i == 6) {
    day = Weekday.sunday;
  } else {
    day = Weekday.monday;
  }

  return day;
}

int weekdayToInt(Weekday day) {
  int i;

  if (day == Weekday.tuesday) {
    i = 1;
  } else if (day == Weekday.wednesday) {
    i = 2;
  } else if (day == Weekday.thursday) {
    i = 3;
  } else if (day == Weekday.friday) {
    i = 4;
  } else if (day == Weekday.saturday) {
    i = 5;
  } else if (day == Weekday.sunday) {
    i = 6;
  } else {
    i = 0;
  }

  return i;
}
