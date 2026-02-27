import 'package:shared_preferences/shared_preferences.dart';

class FavoritesRepo {
  static const String _fKey = 'favorite_users_new';
  final _prefs = SharedPreferencesAsync();

  Future<List<String>> getFavorites() async {
    return await _prefs.getStringList(_fKey) ?? [];
  }

  Future<List<String>> addFavorite(int userId) async {
    final favorites = await getFavorites();
    favorites.add(userId.toString());
    await _prefs.setStringList(_fKey, favorites);
    return favorites;
  }

  Future<List<String>> removeFavorite(int userId) async {
    final favorites = await getFavorites();
    favorites.remove(userId.toString());
    await _prefs.setStringList(_fKey, favorites);
    return favorites;
  }
}
