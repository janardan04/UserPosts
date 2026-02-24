import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ui_state.dart';

class FavoritesBloc extends Cubit<UiState<List<String>>> {
  FavoritesBloc(super.initialState);

  static const String fKey = 'favorite_users_new';
  List<String> favorites = [];
  final prefs = SharedPreferencesAsync();
  int? currentUser;

  Future<void> addToFavorites({required int userId}) async {
    try {
      currentUser = userId;
      // get from prefs
      emit(Loading());
      favorites = await prefs.getStringList(fKey) ?? [];
      // add
      favorites.add(userId.toString());
      // set in prefs
      await prefs.setStringList(fKey, favorites);
      emit(Success(favorites));
    } catch (e) {
      emit(Failure(e.toString()));
    }
  }

  Future<void> removeFromFavorites({required int userId}) async {
    try {
      currentUser = userId;
      // get from prefs
      emit(Loading());
      favorites = await prefs.getStringList(fKey) ?? [];
      // remove
      favorites.remove(userId.toString());
      // set in prefs
      await prefs.setStringList(fKey, favorites);
      emit(Success(favorites));
    } catch (e) {
      emit(Failure(e.toString()));
    }
  }

  Future<void> getFavorites() async {
    try {
      currentUser = null;
      emit(Loading());
      favorites = await prefs.getStringList(fKey) ?? [];
      emit(Success(favorites));
    } catch (e) {
      emit(Failure(e.toString()));
    }
  }

  bool isFavoriteUser({required int userId}) {
    return favorites.contains(userId.toString());
  }
}
