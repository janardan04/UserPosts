import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:api_learning/features/user/adduser/bloc/common_ui_state.dart';
import 'package:api_learning/features/user/favourite/repo/favorites_repo.dart';

class FavoritesBloc extends Cubit<UiState<List<String>>> {
  final FavoritesRepo _repo;

  FavoritesBloc({FavoritesRepo? repo})
    : _repo = repo ?? FavoritesRepo(),
      super(Initial());

  List<String> favorites = [];
  int? currentUser;

  Future<void> addToFavorites({required int userId}) async {
    try {
      currentUser = userId;
      emit(Loading());
      favorites = await _repo.addFavorite(userId);
      emit(Success(favorites));
    } catch (e) {
      emit(Failure(e.toString()));
    }
  }

  Future<void> removeFromFavorites({required int userId}) async {
    try {
      currentUser = userId;
      emit(Loading());
      favorites = await _repo.removeFavorite(userId);
      emit(Success(favorites));
    } catch (e) {
      emit(Failure(e.toString()));
    }
  }

  Future<void> getFavorites() async {
    try {
      currentUser = null;
      emit(Loading());
      favorites = await _repo.getFavorites();
      emit(Success(favorites));
    } catch (e) {
      emit(Failure(e.toString()));
    }
  }

  bool isFavoriteUser({required int userId}) {
    return favorites.contains(userId.toString());
  }
}
