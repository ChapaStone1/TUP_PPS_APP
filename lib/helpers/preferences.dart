import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static late SharedPreferences _prefs;

  static Future<void> initShared() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> clear() async {
    final dark = _prefs.getBool('darkmode') ?? false;
    final favoritos = _prefs.getStringList('favs') ?? [];

    await _prefs.clear();

    await _prefs.setBool('darkmode', dark);
    await _prefs.setStringList('favs', favoritos);
  }

  static bool get darkmode => _prefs.getBool('darkmode') ?? false;

  static set darkmode(bool value) => _prefs.setBool('darkmode', value);

  static String get email => _prefs.getString('email') ?? '';

  static set email(String value) => _prefs.setString('email', value);

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
