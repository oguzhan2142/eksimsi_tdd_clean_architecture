import 'package:connectivity/connectivity.dart';

import 'package:eksimsi_tdd_clean_architecture/core/platform/network_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'network_info_test.mocks.dart';

@GenerateMocks([Connectivity])
main() {
  late MockConnectivity mockConnectivity;
  late NetworkInfoImpl networkInfoImp;

  setUp(() {
    mockConnectivity = MockConnectivity();
    networkInfoImp = NetworkInfoImpl(mockConnectivity);
  });

  void _testWithConnectivityResult(
    ConnectivityResult connectivityResult,
    bool testResult,
  ) async {
    // arrange
    when(mockConnectivity.checkConnectivity())
        .thenAnswer((_) async => connectivityResult);

    // act
    final result = await networkInfoImp.isConnected;

    // assert
    verify(mockConnectivity.checkConnectivity());
    expect(testResult, result);
  }

  group('is connected', () {
    test('should return true when mobile data is on', () async {
      _testWithConnectivityResult(ConnectivityResult.mobile, true);
    });

    test('should return true when wifi is on', () {
      _testWithConnectivityResult(ConnectivityResult.wifi, true);
    });

    test('should return false when both network methods are off', () {
      _testWithConnectivityResult(ConnectivityResult.none, false);
    });
  });
}
