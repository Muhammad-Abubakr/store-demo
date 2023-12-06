import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:demo/models/product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; 
import 'package:meta/meta.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  static const _requestUrl = "https://dummyjson.com/products";
  static const _limit = 100;

  ProductsBloc() : super(ProductsInitial()) {
    /* Event Registration */
    on<InitProducts>(_onInitEvent);
  }

  /// __\_onInitEvent__ handler is used to get the products from the
  /// https://dummyjson.com/data/products with a limit of __100__ products. 
  /// ---
  /// Provides:
  ///   - __initialStream__ : Listen to events from the start of this bloc
  /// ---
  /// Expected Exceptions in state.exception:
  ///   - __http.ClientException__: On http request failure
  ///   - __FormatException__: On URI or Product Parsing failure
  FutureOr<void> _onInitEvent(InitProducts event, Emitter<ProductsState> emit)  async {
    try {
      
      final requestURI = Uri.parse("$_requestUrl?limit=$_limit");
      final response = await http.get(requestURI);

      if (response.statusCode == 200) {
        List<Product> accumulator = List.empty(growable: true);
        final products = jsonDecode(response.body)['products'];

        for (var product in products) {
          final parsedProduct = Product.fromMap(product);
          accumulator.add(parsedProduct);
        }

        emit(ProductsUpdate(products: accumulator));
      } else {
          throw http.ClientException(
              'Error Code ${response.statusCode}: There was an error fetching the products');
      }
      
    } on TypeError catch (error) {
      throw Exception("${error.runtimeType} : Error while preparing the data to display");
    } 
    on Exception catch (error) {
      emit(ProductsError(exception: error));
    }
  }
}
