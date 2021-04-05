enum ResponseState {
  sent,
  viewed,
  accepted,
  declined,
}

ResponseState responseStateFromJson(String str) {
  ResponseState state;

  if (str == 'viewed') {
    state = ResponseState.viewed;
  } else if (str == 'accepted') {
    state = ResponseState.accepted;
  } else if (str == 'declined') {
    state = ResponseState.declined;
  } else {
    state = ResponseState.sent;
  }

  return state;
}

String responseStateToJson(ResponseState state) {
  String str;

  if (state == ResponseState.viewed) {
    str = 'viewed';
  } else if (state == ResponseState.accepted) {
    str = 'accepted';
  } else if (state == ResponseState.declined) {
    str = 'declined';
  } else {
    str = 'sent';
  }

  return str;
}
