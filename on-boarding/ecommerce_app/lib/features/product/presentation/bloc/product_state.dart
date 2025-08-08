import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/product.dart';

@immutable
abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object?> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Product> products;

  const ProductLoaded({required this.products});

  @override
  List<Object?> get props => [products];
}

class ProductError extends ProductState {
  final String message;

  const ProductError({required this.message});

  @override
  List<Object?> get props => [message];
}

// ✅ Add states for add/update/delete operations
class ProductAdded extends ProductState {
  final String message;

  const ProductAdded({required this.message});

  @override
  List<Object?> get props => [message];
}

class ProductDeleted extends ProductState {
  final String message;

  const ProductDeleted({required this.message});

  @override
  List<Object?> get props => [message];
}

class ProductUpdated extends ProductState {
  final String message;

  const ProductUpdated({required this.message});

  @override
  List<Object?> get props => [message];
}
