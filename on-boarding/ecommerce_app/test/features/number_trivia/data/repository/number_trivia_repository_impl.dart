import 'package:ecommerce_app/core/platform/network_info.dart';
import 'package:mockito/mockito.dart';
import 'package:ecommerce_app/features/number_trivia/data/datasources/number_trivia_local_datasource.dart';
import 'package:ecommerce_app/features/number_trivia/data/datasources/number_trivia_remote_datasource.dart';
import 'package:ecommerce_app/features/number_trivia/data/repository/number_trivia_repository_impl.dart';
class MockRemoteDataSource extends Mock{

}

class MockLocalDataSource extends Mock implements NumberTriviaLocalDatasource{}
class MockNetworkInfo extends Mock implements NetworkInfo{}
void main(){
  NumberTriviaRepositoryImpl repositoryImpl;
  MockRemoteDataSource mockRemoteDataSource;
  MockLocalDataSource mockLocalDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(){
    mockLocalDataSource = MockLocalDataSource();
    mockRemoteDataSource = MockRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repositoryImpl = NumberTriviaRepositoryImpl(
      remoteDataSource:mockRemoteDataSource,
      localDataSource:mockLocalDataSource,
      networkInfo:mockNetworkInfo
    );

  }
}
