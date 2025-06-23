import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static late SharedPreferences _prefs;

  static Future<void> initShared() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static bool get darkmode => _prefs.getBool('darkmode') ?? false;

  static set darkmode(bool value) => _prefs.setBool('darkmode', value);

  static String get apellido => _prefs.getString('apellido') ?? '';

  static set apellido(String value) => _prefs.setString('apellido', value);

  static String get email => _prefs.getString('email') ?? '';

  static set email(String value) => _prefs.setString('email', value);

  static String get telefono => _prefs.getString('telefono') ?? '';

  static set telefono(String value) => _prefs.setString('telefono', value);

  static List<String> get favs => _prefs.getStringList('favs') ?? [];

  static void toggleFav(String value) {
    final currentFavs = Set<String>.from(favs);
    if (currentFavs.contains(value)) {
      currentFavs.remove(value);
    } else {
      currentFavs.add(value);
    }
    _prefs.setStringList('favs', currentFavs.toList());
  }
}
