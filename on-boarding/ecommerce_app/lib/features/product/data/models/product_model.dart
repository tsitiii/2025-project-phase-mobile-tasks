import 'package:ecommerce_app/features/product/domain/entities/product.dart';

class ProductModel extends Product {
  ProductModel({
    required String description,
    required int productId,
    required double price,
    required String imageURL,
  }) : super(
         description: description,
         id: productId,
         price: price,
         imageURL: imageURL,
       );

     factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      description: json['description'],
      productId: json['id'],
      price: (json['price'] as num).toDouble(),
      imageURL: json['imageURL'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'id': id,
      'price': price,
      'imageURL': imageURL,
    };
  }
}
