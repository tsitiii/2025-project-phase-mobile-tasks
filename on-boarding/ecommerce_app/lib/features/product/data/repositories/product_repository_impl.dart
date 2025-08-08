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
  });
  @override
  Future<Either<Failure, List<Product>>> getAllProduct() async {
    try {
      if (await networkInfo.isConnected) {
        final List<ProductModel> remoteProducts =
            await remoteDatasource.getAllProducts();

        final List<Product> products =
            remoteProducts
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

        return Right(products);
      } else {
        return Left(
          ServerFailure(
            message: 'No internet connection. Please check your connection.',
          ),
        );
      }
    } on ServerException catch (e) {
      return Left(
        ServerFailure(message: 'Unable to load products. Please try again.'),
      );
    } catch (e) {
      return Left(
        ServerFailure(message: 'An unexpected error occurred: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, void>> addProduct(Product product) async {
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

        return const Right(null);
      } else {
        return Left(
          ServerFailure(
            message: 'No internet connection. Please try again when connected.',
          ),
        );
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: 'Failed to add product to server'));
    } catch (e) {
      return Left(
        ServerFailure(message: 'Failed to add product: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, void>> updateProduct(Product product) async {
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

        return const Right(null);
      } else {
        return Left(
          ServerFailure(
            message: 'No internet connection. Please try again when connected.',
          ),
        );
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: 'Failed to update product on server'));
    } catch (e) {
      return Left(
        ServerFailure(message: 'Failed to update product: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, void>> deleteProduct(String id) async {
    try {
      if (await networkInfo.isConnected) {
        await remoteDatasource.deleteProduct(id);

        return const Right(null);
      } else {
        return Left(
          ServerFailure(
            message: 'No internet connection. Please try again when connected.',
          ),
        );
      }
    } on ServerException catch (e) {
      return Left(
        ServerFailure(message: 'Failed to delete product from server'),
      );
    } catch (e) {
      return Left(
        ServerFailure(message: 'Failed to delete product: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, Product>> getProduct(String id) async {
    try {
      if (await networkInfo.isConnected) {
        final ProductModel productModel = await remoteDatasource.getProduct(id);

        final Product product = Product(
          id: productModel.id,
          name: productModel.name ?? '',
          description: productModel.description ?? '',
          price: productModel.price ?? 0.0,
          imageUrl: productModel.imageUrl ?? '',
        );

        return Right(product);
      } else {
        print('No network connection');
        return Left(
          ServerFailure(
            message: 'No internet connection. Please check your connection.',
          ),
        );
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: 'Product not found or server error'));
    } catch (e) {
      return Left(
        ServerFailure(message: 'An unexpected error occurred: ${e.toString()}'),
      );
    }
  }
}
