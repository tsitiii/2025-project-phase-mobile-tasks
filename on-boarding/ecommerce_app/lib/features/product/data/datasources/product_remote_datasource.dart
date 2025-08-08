import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as path;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';
import '../models/product_model.dart';

class ProductRemoteDatasource {
  SharedPreferences sharedPreferences;
  final http.Client client;
  static const String baseUrl =
      'https://g5-flutter-learning-path-be-tvum.onrender.com';

  ProductRemoteDatasource({
    required this.client,
    required this.sharedPreferences,
  });

  String? _getAccessToken() {
    return sharedPreferences.getString('AUTH_TOKEN');
  }

  Map<String, String> _getAuthHeaders() {
    final token = _getAccessToken();
    if (token == null) {
      throw ServerException();
    }

    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  void _addAuthToMultipart(http.MultipartRequest request) {
    final token = _getAccessToken();
    if (token == null) {
      throw ServerException();
    }

    request.headers.addAll({
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
  }

  Future<List<ProductModel>> getAllProducts() async {
    try {
      final response = await client.get(
        Uri.parse('$baseUrl/api/v2/products'),
        headers: _getAuthHeaders(),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        final List<dynamic> jsonList = jsonResponse['data'] as List<dynamic>;

        final List<ProductModel> products =
            jsonList
                .map(
                  (json) => ProductModel.fromJson(json as Map<String, dynamic>),
                )
                .toList();

        return products;
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  Future<void> addProduct(ProductModel product) async {
    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/api/v2/products'),
      );

      request.fields['name'] = product.name;
      request.fields['description'] = product.description;
      request.fields['price'] = product.price.toString();

      if (product.imageUrl.isNotEmpty &&
          !product.imageUrl.startsWith('http') &&
          File(product.imageUrl).existsSync()) {
        final fileExtension = path.extension(product.imageUrl).toLowerCase();
        MediaType? contentType;

        switch (fileExtension) {
          case '.jpg':
          case '.jpeg':
            contentType = MediaType('image', 'jpeg');
            break;
          case '.png':
            contentType = MediaType('image', 'png');
            break;
          case '.gif':
            contentType = MediaType('image', 'gif');
            break;
          case '.webp':
            contentType = MediaType('image', 'webp');
            break;
          default:
            contentType = MediaType('image', 'jpeg');
        }

        final imageFile = await http.MultipartFile.fromPath(
          'image',
          product.imageUrl,
          contentType: contentType,
        );

        request.files.add(imageFile);
      } else {
        throw Exception('Valid image file is required');
      }

      _addAuthToMultipart(request);

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 201 || response.statusCode == 200) {
        return;
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }




  

  Future<void> updateProduct(ProductModel product) async {
    try {
      final request = http.MultipartRequest(
        'PUT',
        Uri.parse('$baseUrl/api/v2/products/${product.id}'),
      );

      request.fields['name'] = product.name;
      request.fields['description'] = product.description;
      request.fields['price'] = product.price.toString();

      if (product.imageUrl.isNotEmpty) {
        if (!product.imageUrl.startsWith('http') &&
            File(product.imageUrl).existsSync()) {
          final fileExtension = path.extension(product.imageUrl).toLowerCase();
          MediaType? contentType;

          switch (fileExtension) {
            case '.jpg':
            case '.jpeg':
              contentType = MediaType('image', 'jpeg');
              break;
            case '.png':
              contentType = MediaType('image', 'png');
              break;
            case '.gif':
              contentType = MediaType('image', 'gif');
              break;
            case '.webp':
              contentType = MediaType('image', 'webp');
              break;
            default:
              contentType = MediaType('image', 'jpeg');
          }

          final imageFile = await http.MultipartFile.fromPath(
            'image',
            product.imageUrl,
            contentType: contentType,
          );

          request.files.add(imageFile);
        } else {
          request.fields['imageUrl'] = product.imageUrl;
        }
      }

      _addAuthToMultipart(request);

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return;
      } else if (response.statusCode == 404) {
        final patchRequest = http.MultipartRequest(
          'PATCH',
          Uri.parse('$baseUrl/api/v2/products/${product.id}'),
        );

        patchRequest.fields['name'] = product.name;
        patchRequest.fields['description'] = product.description;
        patchRequest.fields['price'] = product.price.toString();

        if (product.imageUrl.isNotEmpty) {
          if (!product.imageUrl.startsWith('http') &&
              File(product.imageUrl).existsSync()) {
            final fileExtension =
                path.extension(product.imageUrl).toLowerCase();
            final contentType = MediaType('image', 'jpeg');

            final imageFile = await http.MultipartFile.fromPath(
              'image',
              product.imageUrl,
              contentType: contentType,
            );

            patchRequest.files.add(imageFile);
          } else {
            patchRequest.fields['imageUrl'] = product.imageUrl;
          }
        }

        _addAuthToMultipart(patchRequest);

        final patchStreamedResponse = await patchRequest.send();
        final patchResponse = await http.Response.fromStream(
          patchStreamedResponse,
        );

        if (patchResponse.statusCode == 200 ||
            patchResponse.statusCode == 201) {
          return;
        } else {
          throw ServerException();
        }
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  Future<void> deleteProduct(String id) async {
    try {
      final response = await client.delete(
        Uri.parse('$baseUrl/api/v2/products/$id'),
        headers: _getAuthHeaders(),
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        return;
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  Future<ProductModel> getProduct(String id) async {
    try {
      final response = await client.get(
        Uri.parse('$baseUrl/api/v2/products/$id'),
        headers: _getAuthHeaders(),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        final productData = jsonResponse['data'] ?? jsonResponse;
        return ProductModel.fromJson(productData);
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }
}
