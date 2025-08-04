import 'dart:convert';

import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/error/exceptions.dart';
import '../../domain/entities/product.dart';
import '../models/product_model.dart';

class ProductLocalDatasource {
  static const String CACHED_PRODUCTS_KEY = 'CACHED_PRODUCTS';
  final SharedPreferences sharedPreferences;

  ProductLocalDatasource({
    required this.sharedPreferences
  });

  Future<void> cacheProducts(List<ProductModel> products) async{
    try {
      final jsonlist = products.map((product)=>product.toJson()).toList();
      final jsonString = json.encode(jsonlist);
      await sharedPreferences.setString(CACHED_PRODUCTS_KEY, jsonString);
    } catch (e) {
      throw CacheException();
  }
}
}