import 'package:eksimsi_tdd_clean_architecture/core/parameters/parameter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late final NoParameter noParameter;

  setUp(() {
    noParameter = NoParameter();
  });
  
  test('should be NoParameter subtype of [BaseParameter]', () {
    // assert
    expect(noParameter, isA<BaseParameter>());
  });
}
