
import 'package:equatable/equatable.dart';

import '../../domain/entities/product.dart';

abstract class ProductState  extends Equatable{
  const ProductState();
  @override
  List<Object?> get props =>[];
}

class ProductEmpty extends ProductState{}
class ProductInitial extends ProductState {
  const ProductInitial();
}

class ProductLoading extends ProductState {
  const ProductLoading();
}

class ProductLoaded extends ProductState {
  final List<Product> products;
  
  const ProductLoaded({required this.products});
  
  @override
  List<Object> get props => [products];
}


class ProductError extends ProductState {
  final String message;
  
  const ProductError({required this.message});
  
  @override
  List<Object> get props => [message];
}

class ProductOperationLoading extends ProductState {
  const ProductOperationLoading();
}

class ProductOperationSuccess extends ProductState {
  final String message;
  
  const ProductOperationSuccess({required this.message});
  
  @override
  List<Object> get props => [message];
}