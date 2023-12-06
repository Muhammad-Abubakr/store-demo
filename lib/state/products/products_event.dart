part of 'products_bloc.dart';

@immutable
sealed class ProductsEvent {}

class InitProducts extends ProductsEvent {}
