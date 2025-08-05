
import 'package:flutter/widgets.dart';

import '../../domain/entities/product.dart';

@immutable
abstract class ProductEvent {
  const ProductEvent();
  @override
  List<Object?> get props => [];
}

class GetAllProductsEvent extends ProductEvent {
  const GetAllProductsEvent();
  
}

class AddProductEvent extends ProductEvent{
  final Product product;
  const AddProductEvent({
    required this.product
  });

  @override
  List<Object> get props => [product];
}

class UpdateProductEvent extends ProductEvent {
  final Product product;
  
  const UpdateProductEvent({required this.product});
  
  @override
  List<Object> get props => [product];
}

class DeleteProductEvent extends ProductEvent {
  final String productId;
  
  const DeleteProductEvent({required this.productId});
  
  @override
  List<Object> get props => [productId];
}