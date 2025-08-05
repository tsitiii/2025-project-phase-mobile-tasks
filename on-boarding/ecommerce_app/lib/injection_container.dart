import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

// Core
import 'core/network/network_info.dart';
import 'core/error/failures.dart';

// Product Feature
import 'features/product/data/datasources/product_remote_datasource.dart';
import 'features/product/data/datasources/product_local_datasource.dart';
import 'features/product/data/repositories/product_repository_impl.dart';
import 'features/product/domain/repositories/product_repository.dart';
// import 'features/product/domain/usecases/get_all_products_usecase.dart';
import 'features/product/domain/usecases/add_product_usecase.dart';

import 'features/product/presentation/bloc/product_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Product
  // Bloc
  sl.registerFactory(() => ProductBloc(
    getAllProductsUsecase: sl(),
    addProductUsecase: sl(),
    // updateProductUsecase: sl(),
    // deleteProductUsecase: sl(),
  ));

  // Use cases
  sl.registerLazySingleton(() => GetAllProductsUsecase(sl()));
  sl.registerLazySingleton(() => AddProductUsecase(sl()));
  // sl.registerLazySingleton(() => UpdateProductUsecase(sl()));
  // sl.registerLazySingleton(() => DeleteProductUsecase(sl()));

  // Repository
  sl.registerLazySingleton<ProductRepository>(() => ProductRepositoryImpl(
    remoteDatasource: sl(),
    localDatasource: sl(),
    networkInfo: sl(),
  ));

  // Data sources
  sl.registerLazySingleton<ProductRemoteDatasource>(
    () => ProductRemoteDatasource(client: sl()),
  );
  sl.registerLazySingleton<ProductLocalDatasource>(
    () => ProductLocalDatasource(sharedPreferences: sl()),
  );

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(connectivityChecker: sl<Connectivity>()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => Connectivity());
}