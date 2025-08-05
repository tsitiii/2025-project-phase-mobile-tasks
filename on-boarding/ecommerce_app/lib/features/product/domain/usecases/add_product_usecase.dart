import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class AddProductUsecase {
  final ProductRepository addProductRepository ;
  AddProductUsecase(this.addProductRepository);

  Future<Either<Failure, void>> call(Product product) {
    return addProductRepository.addProduct(product);
  }
}

class GetAllProductsUsecase{
  final ProductRepository getAllProductRepository;
  GetAllProductsUsecase(this.getAllProductRepository);
  Future<Either<Failure,List<Product>>> call(){
    return getAllProductRepository.getAllProduct();
  }
}


class UpdateProdctUsecase{
  final ProductRepository updateProductRepository;

  UpdateProdctUsecase(this.updateProductRepository);

  // Future<Either<Failure, void>> call(Product product){
  //   return updateProductRepository.updateProduct(product);
  // }
}

class DeleteProdctUsecase{
  final ProductRepository deleteProductRepository;

  DeleteProdctUsecase(this.deleteProductRepository);

  // Future<Either<Failure, void>> call(String, id){
  //   return deleteProductRepository.deleteProduct(id);
  // }
}

class GetProdctUsecase{
  final ProductRepository getroductRepository;

  GetProdctUsecase(this.getroductRepository);

  // Future<Either<Failure, void>> call(String id){
  //   return getroductRepository.deleteProduct(id);
  // }
}