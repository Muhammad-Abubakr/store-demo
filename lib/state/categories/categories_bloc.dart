import 'dart:async';
import 'dart:convert';

import 'package:demo/state/products/products_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/product.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  static const _requestUrl = "https://dummyjson.com/products/categories";
  late final ProductsBloc _productsBloc;

  CategoriesBloc(this._productsBloc) : super(CategoriesInitial()) {
    
    /* Event Registration */
    on<InitCategories>(_onInitEvent);
  }

  /// __\_onInitEvent__ handler is used to get the products categories
  /// from https://dummyjson.com/data/products/categories, parsed and 
  /// put into the CategoriesState.
  /// ---
  /// Expected Exceptions in state.exception:
  ///   - __http.ClientException__: On http request failure
  FutureOr<void> _onInitEvent(InitCategories event, Emitter<CategoriesState> emit) async {
    try {
      final requestURI = Uri.parse(_requestUrl);
      final response = await http.get(requestURI);

      if (response.statusCode == 200) {
        final categories = List.from(jsonDecode(response.body)).cast<String>();

        if (_productsBloc.state.products != null) {
          Map<String, Product> categoryMappedProducts = {};
          for (var category in categories) {
            var product = _productsBloc.state.products!.firstWhere(
              (element) => element.category == category);

            categoryMappedProducts.putIfAbsent(category, () => product); 
          }

          emit(CategoriesUpdate(categories: categories,firstOfCategories: categoryMappedProducts));
        } else {
          throw Exception("Error : Products not available");
        }
      } else {
          throw http.ClientException(
              'Error Code ${response.statusCode}: There was an error fetching the products');
      }
      
    } on TypeError catch (error) {
      throw Exception("${error.runtimeType} : Error while preparing the data to display");
    } on Exception catch (error) {
      emit(CategoriesError(exception: error));
    } 
  }
}
