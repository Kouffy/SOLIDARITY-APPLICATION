import 'package:shared_preferences/shared_preferences.dart';

class SessionManager
{
    static String IS_LOGGED_KEY = 'is_logedin';

    static Future<bool> isUserLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(IS_LOGGED_KEY) == true ? true : false;
  }
}