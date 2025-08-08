import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/product/data/datasources/product_remote_datasource.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repositories/product_repository.dart';
import '../models/product_model.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDatasource remoteDatasource;
  final NetworkInfo networkInfo;

  ProductRepositoryImpl({
    required this.networkInfo,
    required this.remoteDatasource,
  }); // ✅ Removed localDatasource dependency

  @override
  Future<Either<Failure, List<Product>>> getAllProduct() async {
    print('🔍 Repository: Starting getAllProduct...');

    try {
      if (await networkInfo.isConnected) {
        print('🌐 Network connected - fetching from remote...');

        final List<ProductModel> remoteProducts =
            await remoteDatasource.getAllProducts();
        print('✅ Remote fetch successful: ${remoteProducts.length} products');

        // ✅ No caching - just return the products directly
        final List<Product> products = remoteProducts
            .map(
              (model) => Product(
                id: model.id,
                name: model.name ?? '',
                description: model.description ?? '',
                price: model.price ?? 0.0,
                imageUrl: model.imageUrl ?? '',
              ),
            )
            .toList();

        print('🎉 Repository: Returning ${products.length} products');
        return Right(products);
      } else {
        print('❌ No network connection');
        return Left(
          ServerFailure(
            message: 'No internet connection. Please check your connection.',
          ),
        );
      }
    } on ServerException catch (e) {
      print('🚨 ServerException caught: $e');
      return Left(
        ServerFailure(
          message: 'Unable to load products. Please try again.',
        ),
      );
    } catch (e) {
      print('❌ Unexpected error: $e');
      return Left(
        ServerFailure(message: 'An unexpected error occurred: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, void>> addProduct(Product product) async {
    print('➕ Repository: Adding product...');

    try {
      if (await networkInfo.isConnected) {
        final ProductModel productModel = ProductModel(
          id: product.id,
          name: product.name,
          description: product.description,
          price: product.price,
          imageUrl: product.imageUrl,
        );

        await remoteDatasource.addProduct(productModel);
        print('✅ Product added to remote successfully');

        // ✅ No cache update needed
        return const Right(null);
      } else {
        print('❌ No network connection for adding product');
        return Left(
          ServerFailure(
            message: 'No internet connection. Please try again when connected.',
          ),
        );
      }
    } on ServerException catch (e) {
      print('❌ Server error adding product: $e');
      return Left(
        ServerFailure(message: 'Failed to add product to server'),
      );
    } catch (e) {
      print('❌ Unexpected error adding product: $e');
      return Left(
        ServerFailure(message: 'Failed to add product: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, void>> updateProduct(Product product) async {
    print('🔄 Repository: Updating product...');

    try {
      if (await networkInfo.isConnected) {
        final ProductModel productModel = ProductModel(
          id: product.id,
          name: product.name,
          description: product.description,
          price: product.price,
          imageUrl: product.imageUrl,
        );

        await remoteDatasource.updateProduct(productModel);
        print('✅ Product updated on remote successfully');

        // ✅ No cache update needed
        return const Right(null);
      } else {
        print('❌ No network connection for updating product');
        return Left(
          ServerFailure(
            message: 'No internet connection. Please try again when connected.',
          ),
        );
      }
    } on ServerException catch (e) {
      print('❌ Server error updating product: $e');
      return Left(
        ServerFailure(message: 'Failed to update product on server'),
      );
    } catch (e) {
      print('❌ Unexpected error updating product: $e');
      return Left(
        ServerFailure(message: 'Failed to update product: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, void>> deleteProduct(String id) async {
    print('🗑️ Repository: Deleting product with ID: $id');

    try {
      if (await networkInfo.isConnected) {
        await remoteDatasource.deleteProduct(id);
        print('✅ Product deleted from remote successfully');

        // ✅ No cache update needed
        return const Right(null);
      } else {
        print('❌ No network connection for deleting product');
        return Left(
          ServerFailure(
            message: 'No internet connection. Please try again when connected.',
          ),
        );
      }
    } on ServerException catch (e) {
      print('❌ Server error deleting product: $e');
      return Left(
        ServerFailure(message: 'Failed to delete product from server'),
      );
    } catch (e) {
      print('❌ Unexpected error deleting product: $e');
      return Left(
        ServerFailure(message: 'Failed to delete product: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, Product>> getProduct(String id) async {
    print('🔍 Repository: Getting product with ID: $id');

    try {
      if (await networkInfo.isConnected) {
        final ProductModel productModel =
            await remoteDatasource.getProduct(id);
        print('✅ Product fetched from remote successfully');

        final Product product = Product(
          id: productModel.id,
          name: productModel.name ?? '',
          description: productModel.description ?? '',
          price: productModel.price ?? 0.0,
          imageUrl: productModel.imageUrl ?? '',
        );

        return Right(product);
      } else {
        print('❌ No network connection');
        return Left(
          ServerFailure(
            message: 'No internet connection. Please check your connection.',
          ),
        );
      }
    } on ServerException catch (e) {
      print('🚨 ServerException caught: $e');
      return Left(
        ServerFailure(message: 'Product not found or server error'),
      );
    } catch (e) {
      print('❌ Unexpected error: $e');
      return Left(
        ServerFailure(message: 'An unexpected error occurred: ${e.toString()}'),
      );
    }
  }
}