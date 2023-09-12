import 'package:shared_preferences/shared_preferences.dart';

class PreferenceTest {
  static void sharedPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool isLogged = await preferences.getBool('isLogged')! ?? false;
    print(isLogged);
  }
}
