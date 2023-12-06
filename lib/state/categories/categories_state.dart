part of 'categories_bloc.dart';

@immutable
sealed class CategoriesState {
  final List<String>? categories;
  final Map<String, Product>? firstOfCategories;
  final Exception? exception;

  const CategoriesState({this.categories, this.exception, this.firstOfCategories});
}

final class CategoriesInitial extends CategoriesState {}

final class CategoriesUpdate extends CategoriesState {
  const CategoriesUpdate({super.categories, super.firstOfCategories});
}

final class CategoriesError extends CategoriesState {
  const CategoriesError({required super.exception});
}