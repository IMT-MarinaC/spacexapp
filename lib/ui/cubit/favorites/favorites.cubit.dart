import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'favorites.state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit() : super(FavoritesState(favoritesIds: {})) {
    _loadFavorites();
  }

  // Charge fav depuis SharedPreferences
  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final savedIds = prefs.getStringList('favorites') ?? [];

    emit(FavoritesState(favoritesIds: savedIds.toSet()));
  }

  // Ajoute / supprime dans les favoris
  Future<void> toggleFavorite(String id) async {
    final newSet = Set<String>.from(state.favoritesIds);

    if (newSet.contains(id)) {
      newSet.remove(id);
    } else {
      newSet.add(id);
    }

    emit(state.copyWith(favoritesIds: newSet));

    // Sauvegarde locale
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('favorites', newSet.toList());
  }

  bool isFavorite(String id) {
    return state.favoritesIds.contains(id);
  }
}
