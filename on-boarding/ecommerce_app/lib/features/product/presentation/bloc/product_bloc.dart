import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/add_product_usecase.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetAllProductsUsecase getAllProductsUsecase;
  final AddProductUsecase addProductUsecase;
  final DeleteProdctUsecase deleteProductUsecase;
  final UpdateProdctUsecase updateProductUsecase;

  ProductBloc({
    required this.getAllProductsUsecase,
    required this.addProductUsecase,
    required this.deleteProductUsecase,
    required this.updateProductUsecase,
  }) : super(ProductInitial()) {
    on<GetAllProductsEvent>(_onGetAllProducts);
    on<AddProductEvent>(_onAddProduct);
    on<DeleteProductEvent>(_onDeleteProduct);
    on<UpdateProductEvent>(_onUpdateProduct);
  }

  Future<void> _onGetAllProducts(
    GetAllProductsEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());

    final result = await getAllProductsUsecase.call();
    result.fold(
      (failure) => emit(ProductError(message: failure.message)),
      (products) => emit(ProductLoaded(products: products)),
    );
  }

  Future<void> _onAddProduct(
    AddProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());

    print('🆕 ProductBloc: Adding product ${event.product.name}');

    final result = await addProductUsecase.call(event.product);
    result.fold(
      (failure) {
        print('❌ ProductBloc: Add product failed: ${failure.message}');
        emit(ProductError(message: failure.message));
      },
      (_) {
        print('✅ ProductBloc: Product added successfully');
        emit(const ProductAdded(message: 'Product added successfully!'));

        add(const GetAllProductsEvent());
      },
    );
  }

  Future<void> _onDeleteProduct(
    DeleteProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());

    final result = await deleteProductUsecase.call(event.id);
    result.fold((failure) => emit(ProductError(message: failure.message)), (_) {
      emit(const ProductDeleted(message: 'Product deleted successfully!'));
      add(const GetAllProductsEvent());
    });
  }

  Future<void> _onUpdateProduct(
    UpdateProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());

    final result = await updateProductUsecase.call(event.product);
    result.fold((failure) => emit(ProductError(message: failure.message)), (_) {
      emit(const ProductUpdated(message: 'Product updated successfully!'));
      add(const GetAllProductsEvent());
    });
  }
}
