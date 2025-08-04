import 'package:ecommerce_app/core/network/network_info.dart';
import 'package:ecommerce_app/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ecommerce_app/features/number_trivia/data/datasources/number_trivia_local_datasource.dart';
import 'package:ecommerce_app/features/number_trivia/data/datasources/number_trivia_remote_datasource.dart';
import 'package:ecommerce_app/features/number_trivia/data/repository/number_trivia_repository_impl.dart';
class MockRemoteDataSource extends Mock implements NumberTriviaRemoteDatasource {

}

class MockLocalDataSource extends Mock implements NumberTriviaLocalDatasource{}
class MockNetworkInfo extends Mock implements NetworkInfo{}
void main(){
  NumberTriviaRepositoryImpl? repositoryImpl;
  MockRemoteDataSource? mockRemoteDataSource;
  MockLocalDataSource? mockLocalDataSource;
  MockNetworkInfo? mockNetworkInfo;
  NumberTriviaModel? tNumberTriviaModel;
  setUp((){
    mockLocalDataSource = MockLocalDataSource();
    mockRemoteDataSource = MockRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repositoryImpl = NumberTriviaRepositoryImpl(
      localDatasource:mockLocalDataSource!,
      remoteDatasource:mockRemoteDataSource!,
      networkInfo:mockNetworkInfo!
    );
  });

  group("testing the repository implementation",
  (){
    test("should check online or not", ()async{
      when(mockNetworkInfo!.isConnected).thenAnswer((_)async =>true);
      repositoryImpl!.getConcreteNUmberTrivia(1);
      verify(mockNetworkInfo!.isConnected);
    });

    test("return remote data",
    ()async{
        final tNumberTriviaModelNonNull = NumberTriviaModel(number: 1, text: "Test trivia");
        when(mockRemoteDataSource!.getConcreteNUmberTrivia(any, any)).thenAnswer((_) async => tNumberTriviaModelNonNull);
    });
  });
}
