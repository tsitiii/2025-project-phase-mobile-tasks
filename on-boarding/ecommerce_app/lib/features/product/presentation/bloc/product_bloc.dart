import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/error/failures.dart';
import '../../domain/usecases/add_product_usecase.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState>{
  final GetAllProductsUsecase getAllProductsUsecase;
  final AddProductUsecase addProductUsecase;

  ProductBloc({
    required this.getAllProductsUsecase,
    required this.addProductUsecase
  }) : super(const ProductInitial()) {
    on<GetAllProductsEvent>(_onGetAllProducts);
    on<AddProductEvent>(_onAddProduct);
  }

  Future<void> _onGetAllProducts(GetAllProductsEvent event, Emitter<ProductState> emit) async {
    emit(const ProductLoading());
    final result = await getAllProductsUsecase.call();
    
    result.fold(
      (failure) => emit(ProductError(message: _mapFailureToMessage(failure))), // ✅ Specific handling
      (products) => emit(ProductLoaded(products: products)),
    );
  }

  Future<void> _onAddProduct(
    AddProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(const ProductOperationLoading());
    final result = await addProductUsecase.call(event.product);

    result.fold(
      (failure) => emit(ProductError(message: _mapFailureToMessage(failure))), // ✅ Specific handling
      (_) {
        emit(const ProductOperationSuccess(message: 'Product added successfully!'));
        add(const GetAllProductsEvent());
      },
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server Error: Please try again later';
      case CacheFailure:
        return 'Cache Error: Unable to load cached data';
      case ConnectionFailure:
        return 'Connection Error: Check your internet connection';
      default:
        return 'Unexpected Error: Something went wrong';
    }
  }
}

class ConnectionFailure {
}