import 'package:ecommerce_app/core/network/network_info.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../../features/number_trivia/data/repository/number_trivia_repository_impl.dart';

class MockConectivityChecker extends Mock implements Connectivity{
  
}

void main(){
  late NetworkInfoImpl networkInfoImpl;
  late MockConectivityChecker mockConnectivityChecker;
  setUp((){
    mockConnectivityChecker = MockConectivityChecker();
    networkInfoImpl = NetworkInfoImpl(connectivityChecker: mockConnectivityChecker);
  });
group("the isConnected connection checker", (){
  test("should forward call to ConnectionChecker", () async {
    when(mockConnectivityChecker.checkConnectivity())
        .thenAnswer((_) async => [ConnectivityResult.wifi]);

    final result = await networkInfoImpl.isConnected;
    verify(mockConnectivityChecker.checkConnectivity());
    expect(result, true);
  });
});
}