part of 'favourites_cubit.dart';

@immutable
sealed class FavouritesState {
  final List<int> favourites;

  const FavouritesState({required this.favourites});
}

final class FavouritesInitial extends FavouritesState {
  FavouritesInitial() : super(favourites: List.empty(growable: true));
}

final class FavouritesUpdate extends FavouritesState {
  const FavouritesUpdate({required super.favourites});
}
