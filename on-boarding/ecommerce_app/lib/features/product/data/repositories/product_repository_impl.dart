import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/product/data/datasources/product_local_datasource.dart';
import 'package:ecommerce_app/features/product/data/datasources/product_remote_datasource.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../../../product.dart';
import '../../domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository{
    final ProductLocalDatasource localDatasource;
    final ProductRemoteDatasource remoteDatasource;
    final NetworkInfo networkInfo;
    ProductRepositoryImpl({
      required  this.localDatasource,
      required this.networkInfo,
      required this.remoteDatasource
    });

  Future<Either<Failure, void>> addProduct(Product product) async{
    
  }

  
  Future<Either<Failure, List<Product>>> getAllProduct() async{
      if (await networkInfo.isConnected) {
      final products =  await remoteDatasource.fetchProducts();
      await localDatasource.cacheProducts(products);
      return Right(products.map(model)=>model.toEntity()).toList();
    }
    else{
      final cahedproducts = await localDatasource.cahedProducts();
      return cahedproducts;
    }
  }














  Future<Either<Failure, void>> updateProduct(Product product){

  }
  Future<Either<Failure, void>> deleteProduct(String id){
    
  }
  Future<Either<Failure, Product>> getProduct(String id){

  }

}