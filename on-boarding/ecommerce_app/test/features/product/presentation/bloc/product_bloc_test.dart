
import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failures.dart';
import 'package:ecommerce_app/features/product/domain/usecases/add_product_usecase.dart';
import 'package:ecommerce_app/features/product/presentation/bloc/product_bloc.dart';
import 'package:ecommerce_app/features/product/presentation/bloc/product_event.dart';
import 'package:ecommerce_app/features/product/presentation/bloc/product_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockGetAllProduct extends Mock implements GetAllProductsUsecase{

}
class MockAddProduct extends Mock implements AddProductUsecase{}
void main(){
  late ProductBloc bloc;
  late MockGetAllProduct mockGetAllProduct;
  late MockAddProduct mockAddProduct;
  
  setUp((){
    mockAddProduct = MockAddProduct();
    mockGetAllProduct = MockGetAllProduct();
    bloc = ProductBloc(getAllProductsUsecase: mockGetAllProduct, addProductUsecase: mockAddProduct);

  });

  group("testing the product usecase and the bloc", (){
    test("testing the get all product usecase, initial state should be empty", (){
      //arrange

      //act

      //assert
      expect(bloc.state,equals( const ProductInitial()));
    });

    test("should emit error when input is invalid",()async{
        when(mockGetAllProduct.call()).thenAnswer((_) async => Left(ServerFailure()));
        bloc.add(const GetAllProductsEvent());

        final expected = [
          const ProductInitial(),
          Error(),
        ];
        
    });
  });

}