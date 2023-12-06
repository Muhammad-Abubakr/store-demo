import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'favourites_state.dart';

class FavouritesCubit extends Cubit<FavouritesState> {
  FavouritesCubit() : super(FavouritesInitial());

  /// Toggles the status of favourite for the given product
  void toggleFavourite(int productId) {
    List<int> updatedFavourites = [...state.favourites];
    if (!updatedFavourites.remove(productId)) {
      updatedFavourites.add(productId);
    }
    emit(FavouritesUpdate(favourites: updatedFavourites));
  }

  /// Check the status of the product favourite status
  bool checkIsFavourite(int productId) {
    return state.favourites.contains(productId);
  }
}
