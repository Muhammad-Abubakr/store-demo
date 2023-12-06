import 'package:demo/state/categories/categories_bloc.dart';
import 'package:demo/state/favourites/favourites_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app.dart';
import 'state/products/products_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => ProductsBloc()..add(InitProducts())),
      BlocProvider(
        create: (context) => CategoriesBloc(
          context.read<ProductsBloc>(),
        )..add(InitCategories()),
      ),
      BlocProvider(create: (_) => FavouritesCubit()),
    ],
    child: const MyApp(),
  ));
}
