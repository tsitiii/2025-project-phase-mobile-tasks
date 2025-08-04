import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import '../../../../core/error/exceptions.dart';
import '../../domain/entities/product.dart';
import 'package:ecommerce_app/features/product/data/models/product_model.dart';

class ProductRemoteDatasource {
  final http.Client client;
  static const String baseUrl = 'https://g5-flutter-learning-path-be.onrender.com/';
  ProductRemoteDatasource({required this.client});


@override
  Future<List<ProductModel>> getAllProducts() async {
    try {
      final response = await client.get(
        Uri.parse('$baseUrl/products'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => ProductModel.fromJson(json)).toList();
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }



}