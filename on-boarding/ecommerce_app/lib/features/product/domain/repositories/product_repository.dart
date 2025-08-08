import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/product.dart';
abstract class ProductRepository {
  Future<Either<Failure, void>> addProduct(Product product);
  Future<Either<Failure, List<Product>>> getAllProduct();
  Future<Either<Failure, void>> updateProduct(Product product);
  Future<Either<Failure, void>> deleteProduct(String id);
  Future<Either<Failure, Product>> getProduct(String id);

}
