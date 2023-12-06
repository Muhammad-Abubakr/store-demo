import 'pages/categories_page.dart';
import 'pages/favourites_page.dart';
import 'pages/products_page.dart';
import 'pages/profile_page.dart';

final List<Set> pages= [
    {"Products", const ProductsPage()},
    {"Categories", const CategoriesPage()},
    {"Favourites", const FavouritesPage()},
    {"Mitt Konto", const ProfilePage()}, // Corresponds to profilePageIndex
];
int get profilePageIndex => pages.indexWhere((element) => element.last.runtimeType==ProfilePage);
  
  