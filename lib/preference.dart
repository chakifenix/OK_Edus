import 'package:shared_preferences/shared_preferences.dart';

class PreferenceTest {
  SharedPreferences? preferences;
  void sharedPref() async {
    preferences = await SharedPreferences.getInstance();
    bool isLogged = await preferences!.getBool('isLogged')! ?? false;
    print(isLogged);
  }

  void saveLanguage() async {
    preferences = await SharedPreferences.getInstance();
  }
}
