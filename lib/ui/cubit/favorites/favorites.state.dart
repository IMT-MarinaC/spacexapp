class FavoritesState {
  final Set<String> favoritesIds;

  FavoritesState({required this.favoritesIds});

  FavoritesState copyWith({Set<String>? favoritesIds}) {
    return FavoritesState(favoritesIds: favoritesIds ?? this.favoritesIds);
  }
}
