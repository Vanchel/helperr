enum WorkType {
  fullDay,
  partDay,
  fullTime,
  partTime,
  volunteer,
  oneTimeJob,
  flexibleSchedule,
  shiftSchedule,
  shiftMethod,
  remote
}

WorkType workTypeFromJson(String str) {
  WorkType type;

  if (str == 'part-day') {
    type = WorkType.partDay;
  } else if (str == 'full-time') {
    type = WorkType.fullTime;
  } else if (str == 'part-time') {
    type = WorkType.partTime;
  } else if (str == 'volunteer') {
    type = WorkType.volunteer;
  } else if (str == 'one-time-job') {
    type = WorkType.oneTimeJob;
  } else if (str == 'flexible-schedule') {
    type = WorkType.flexibleSchedule;
  } else if (str == 'shift-schedule') {
    type = WorkType.shiftSchedule;
  } else if (str == 'shift-method') {
    type = WorkType.shiftMethod;
  } else if (str == 'remote') {
    type = WorkType.remote;
  } else {
    type = WorkType.fullDay;
  }

  return type;
}

String workTypeToJson(WorkType type) {
  String str;

  if (type == WorkType.partDay) {
    str = 'part-day';
  } else if (type == WorkType.fullTime) {
    str = 'full-time';
  } else if (type == WorkType.partTime) {
    str = 'part-time';
  } else if (type == WorkType.volunteer) {
    str = 'volunteer';
  } else if (type == WorkType.oneTimeJob) {
    str = 'one-time-job';
  } else if (type == WorkType.flexibleSchedule) {
    str = 'flexible-schedule';
  } else if (type == WorkType.shiftSchedule) {
    str = 'shift-schedule';
  } else if (type == WorkType.shiftMethod) {
    str = 'shift-method';
  } else if (type == WorkType.remote) {
    str = 'remote';
  } else {
    str = 'full-day';
  }

  return str;
}
