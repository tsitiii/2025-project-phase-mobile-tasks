import 'package:ecommerce_app/features/product/domain/entities/product.dart';

class ProductModel extends Product {
  ProductModel({
    required String description,
    required int productId,
    required double price,
    required String imageUrl,
  }) : super(
         description: description,
         id: productId,
         price: price,
         imageUrl: imageUrl,
       );

     factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      description: json['description'],
      productId: json['id'],
      price: (json['price'] as num).toDouble(),
      imageUrl: json['imageURL'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'id': id,
      'price': price,
      'imageURL': imageUrl,
    };
  }
}
