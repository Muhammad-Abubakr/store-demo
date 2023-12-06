part of 'products_bloc.dart';

@immutable
sealed class ProductsState {
  final List<Product>? products;
  final Exception? exception;

  const ProductsState({this.products, this.exception});
}

final class ProductsInitial extends ProductsState {}

final class ProductsUpdate extends ProductsState {
  const ProductsUpdate({super.products});
}

final class ProductsError extends ProductsState {
  const ProductsError({super.exception});
}
