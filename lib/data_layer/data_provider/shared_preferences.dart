import 'package:shared_preferences/shared_preferences.dart';

Future<LoginData> getLoginData() async {
  final preferences = await SharedPreferences.getInstance();
  final email = preferences.getString('email');
  final password = preferences.getString('password');

  return (email == null || password == null)
      ? null
      : LoginData(email, password);
}

Future<void> saveLoginData(String email, String password) async {
  final preferences = await SharedPreferences.getInstance();
  preferences.setString('email', email);
  preferences.setString('password', password);
}

Future<void> deleteLoginData() async {
  final preferences = await SharedPreferences.getInstance();
  preferences.remove('email');
  preferences.remove('password');
}

class LoginData {
  LoginData(this.email, this.password);

  final String email;
  final String password;
}
