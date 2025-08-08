import 'package:ecommerce_app/features/product/domain/entities/product.dart';

class ProductModel extends Product {
  ProductModel({
    required String description,
    required String id,
    required double price,
    required String imageUrl,
    required String name,
  }) : super(
          description: description,
          id: id,
          price: price,
          imageUrl: imageUrl,
          name: name,
        );

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      description: json['description'] ?? '',
      id: json['id'] ?? '',
      price:
          (json['price'] as num?)?.toDouble() ??
          0.0, 
      imageUrl: json['imageUrl'] ?? '',
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'id': id,
      'price': price.toString(),
      'imageUrl': imageUrl,
      'name': name,
    };
  }
}
