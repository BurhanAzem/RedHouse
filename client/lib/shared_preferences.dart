import 'package:shared_preferences/shared_preferences.dart';

Future<void> setVisitor(bool value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('visitor', value);
}

Future<bool> getVisitor() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('visitor') ?? false;
}
