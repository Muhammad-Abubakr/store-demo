import 'package:demo/state/favourites/favourites_cubit.dart';
import 'package:demo/state/products/products_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../models/product.dart';

class FavouritesPage extends StatefulWidget {
  const FavouritesPage({super.key});

  @override
  State<FavouritesPage> createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  late FavouritesCubit favouritesCubit;
  late FavouritesState favouritesState;
  late List<int> favourites;
  late ProductsBloc productsBloc;
  late List<Product>? products;
  late List<Product>? favouriteProducts;

  @override
  void didChangeDependencies() {
    favouritesCubit = context.watch<FavouritesCubit>();
    favouritesState = favouritesCubit.state;
    favourites = favouritesCubit.state.favourites;
    productsBloc = context.watch<ProductsBloc>();
    products = productsBloc.state.products;
    favouriteProducts =
        products?.where((element) => favourites.contains(element.id)).toList();

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.orientationOf(context) == Orientation.landscape;

    if (favouritesState.favourites.isEmpty) {
      return const Center(
        child: Text("Your favourite products will show here"),
      );
    } else {
      return CustomScrollView(
        slivers: <Widget>[
          // App Bar containing Search Field and Results indicator
          SliverAppBar(
            floating: true,
            automaticallyImplyLeading: false,
            expandedHeight: isLandscape ? 0.12.sw : 0.12.sh,
            toolbarHeight: isLandscape ? 0.12.sw : 0.12.sh,
            flexibleSpace: Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.05.sw),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Search Field
                  TextField(
                    onChanged: searchFilter,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),

                  SizedBox(height: 20.h),

                  // Number of results indicator
                  Text("showing ${favouriteProducts?.length} results",
                      style: TextStyle(color: Colors.grey, fontSize: 12.spMax))
                ],
              ),
            ),
          ),

          // Favourites List builder
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 0.05.sw),
            sliver: SliverList.builder(
              itemBuilder: (_, index) {
                var product = favouriteProducts![index];

                return Container(
                  margin: EdgeInsets.symmetric(vertical: 32.r),
                  padding: EdgeInsets.all(32.r),
                  decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.grey.shade200,
                      ),
                      borderRadius: BorderRadius.circular(12.r)),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 76.r,
                        backgroundImage: Image.network(
                          product.thumbnail,
                          fit: BoxFit.cover,
                        ).image,
                      ),

                      SizedBox(width: 32.w),

                      // Details
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.title,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                ),
                                Text(
                                  "\$${product.price}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                        color: Colors.black,
                                        fontSize: 9.spMax,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "${product.rating}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 9.spMax),
                                    ),
                                    SizedBox(width: 10.w),
                                    RatingBarIndicator(
                                      rating: product.rating,
                                      itemBuilder: (context, index) =>
                                          const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      itemCount: 5,
                                      itemSize: 10.spMax,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            IconButton(
                              onPressed: () =>
                                  favouritesCubit.toggleFavourite(product.id),
                              icon: const Icon(Icons.favorite,
                                  color: Colors.redAccent),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
              itemCount: favouriteProducts?.length,
            ),
          ),
        ],
      );
    }
  }

  // Helper Functions
  Product getProduct(int productId) {
    return favouriteProducts!.firstWhere((element) => element.id == productId);
  }

  void searchFilter(String text) {
    setState(() => favouriteProducts = products!
        .where((p) =>
            favourites.contains(p.id) &&
            (p.title.toLowerCase().contains(text.toLowerCase()) ||
                p.brand.toLowerCase().contains(text.toLowerCase()) ||
                p.category.toLowerCase().contains(text.toLowerCase())))
        .toList());
  }
}
