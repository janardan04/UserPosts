import 'package:shared_preferences/shared_preferences.dart';

class FavoriteService {
  final asyncPrefs = SharedPreferencesAsync();

  static Future<List<String>> addFavorite(int id) async {
    final asyncPrefs = SharedPreferencesAsync();
    List<String> favorite =
        await asyncPrefs.getStringList('favorite_user') ?? [];
    if (!favorite.contains(id.toString())) {
      favorite.add(id.toString());
    }
    await asyncPrefs.setStringList('favorite_user', favorite);
    print('>>>>> After setting in PREFS, updated list is : ${favorite}');

    return favorite;
  }

  static Future<List<String>?> getFavorite() async {
    final asyncPrefs = SharedPreferencesAsync();
    List<String>? l = await asyncPrefs.getStringList('favorite_user');

    return l;
  }

  static Future<List<String>> removeFav(int id) async {
    final asyncPrefs = SharedPreferencesAsync();

    List<String> favorite =
        await asyncPrefs.getStringList('favorite_user') ?? [];

    favorite.remove(id.toString());

    await asyncPrefs.setStringList('favorite_user', favorite);
    print(">>>>>>>>the id $id remove");
    print('and Updated list is ${favorite}');
    return favorite;
  }
}
