import 'package:shared_preferences/shared_preferences.dart';

Future<void> setToken(String value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('token', value);
}

Future<String> getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('token') ?? "98y";
}

Future<void> setUser(String value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('user', value);
}

Future<String> getUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('user') ?? "98y";
}
