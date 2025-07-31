import 'package:ecommerce_app/features/product/data/models/product_model.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final productModel = ProductModel(
    description: "mock description",
    productId: 1,
    price: 23.0,
    imageURL: "image/path",
  );

  final productJson = {
    'description': "mock description",
    'id': 1,
    'price': 23.0,
    'imageURL': "image/path",
  };

  group('Test ProductModel', () {
    test('should be a subclass of Product entity', () {
      expect(productModel, isA<Product>());
    });

    test('fromJson should return a valid model', () {
      final result = ProductModel.fromJson(productJson);
      expect(result.description, equals("mock description"));
      expect(result.id, equals(1));
      expect(result.price, equals(23.0));
      expect(result.imageURL, equals("image/path"));
    });

    test('toJson should return a valid JSON map', () {
      final result = productModel.toJson();
      expect(result, equals(productJson));
    });
  });
}
