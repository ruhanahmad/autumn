import 'package:autmn/main.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SharedPreferencesService {
  static Future<void> savePassword(String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('password', password);
  }

  static Future<String?> getPassword() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('password');
  }
}
