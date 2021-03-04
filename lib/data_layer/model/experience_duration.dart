enum ExperienceDuration {
  noExperience,
  lessThanYear,
  oneToThreeYears,
  threeToFiveYears,
  moreThanFiveYears
}

ExperienceDuration experienceDurationFromJson(String str) {
  ExperienceDuration duration;

  if (str == 'less-than-year') {
    duration = ExperienceDuration.lessThanYear;
  } else if (str == 'one-to-three-years') {
    duration = ExperienceDuration.oneToThreeYears;
  } else if (str == 'three-to-five-years') {
    duration = ExperienceDuration.threeToFiveYears;
  } else if (str == 'more-than-five-years') {
    duration = ExperienceDuration.moreThanFiveYears;
  } else {
    duration = ExperienceDuration.noExperience;
  }

  return duration;
}

String experienceDurationToJson(ExperienceDuration duration) {
  String str;

  if (duration == ExperienceDuration.lessThanYear) {
    str = 'less-than-year';
  } else if (duration == ExperienceDuration.oneToThreeYears) {
    str = 'one-to-three-years';
  } else if (duration == ExperienceDuration.threeToFiveYears) {
    str = 'three-to-five-years';
  } else if (duration == ExperienceDuration.moreThanFiveYears) {
    str = 'more-than-five-years';
  } else {
    str = 'no-experience';
  }

  return str;
}
