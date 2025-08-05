import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/product/data/datasources/product_local_datasource.dart';
import 'package:ecommerce_app/features/product/data/datasources/product_remote_datasource.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../models/product_model.dart';
import '../../../../core/error/exceptions.dart'; // Ensure this import exists for CacheException and ServerException

class ProductRepositoryImpl implements ProductRepository{
    final ProductLocalDatasource localDatasource;
    final ProductRemoteDatasource remoteDatasource;
    final NetworkInfo networkInfo;
    ProductRepositoryImpl({
      required  this.localDatasource,
      required this.networkInfo,
      required this.remoteDatasource
    });


@override
Future<Either<Failure, List<Product>>> getAllProduct() async {
  try {
    if (await networkInfo.isConnected) {
      final List<ProductModel> remoteProducts = await remoteDatasource.getAllProducts();
      await localDatasource.cacheProducts(remoteProducts);
      
      final List<Product> products = remoteProducts.map((model) => Product(
        id: model.id,
        description: model.description,
        price: model.price,
        imageUrl: model.imageUrl,
      )).toList();
      
      return Right(products);
    } else {
      final List<ProductModel> cachedProducts = await localDatasource.getCachedProducts();
      final List<Product> products = cachedProducts.map((model) => Product(
        id: model.id,
        description: model.description,
        price: model.price,
        imageUrl: model.imageUrl,
      )).toList();
      
      return Right(products);
    }
  } on ServerException {
    try {
      final List<ProductModel> cachedProducts = await localDatasource.getCachedProducts();
      final List<Product> products = cachedProducts.map((model) => Product(
        id: model.id,
        description: model.description,
        price: model.price,
        imageUrl: model.imageUrl,
      )).toList();
      return Right(products);
    } on CacheException catch (_) {
      return Left(ServerFailure());
    }
  } on CacheException catch (_) {
    return Left(CacheFailure());
  } catch (e) {
    return Left(ServerFailure());
  }
}



  Future<Either<Failure, void>> addProduct(Product product) async{
    try {
      if (await networkInfo.isConnected) {
        final ProductModel productModel = ProductModel(
          productId: product.id,
          description: product.description ,
          price: product.price,
          imageUrl: product.imageUrl );
          await remoteDatasource.addProduct(productModel);
          final List<ProductModel> products = [productModel];
          await localDatasource.cacheProducts(products);
          return const Right(null);
      }
      else{
        return Left(ServerFailure());
      }
    } catch (e) {
      return Left(ServerFailure());
    }
  }

}