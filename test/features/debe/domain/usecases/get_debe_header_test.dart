
import 'package:dartz/dartz.dart';
import 'package:eksimsi_tdd_clean_architecture/features/debe/domain/entities/debe_header.dart';
import 'package:eksimsi_tdd_clean_architecture/features/debe/domain/repositories/debe_repository.dart';
import 'package:eksimsi_tdd_clean_architecture/features/debe/domain/usecases/get_debe_headers.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';


import 'get_debe_header_test.mocks.dart';

@GenerateMocks([DebeRepository])
main() {
  late final MockDebeRepository mockDebeRepository;
  late final GetDebeHeaders useCase;

  setUp(() {
    mockDebeRepository = MockDebeRepository();
    useCase = GetDebeHeaders(mockDebeRepository);
  });

  final debeHeaders = <DebeHeader>[
    DebeHeader(title: 'debe title', href: 'href'),
  ];

  test('should c all mock debe repository when call GetDebeHeaders usecase',
      () async {
    // arrange
    when(mockDebeRepository.getDebeHeaders())
        .thenAnswer((_) async => Right(debeHeaders));

    // act
    final result = await useCase();

    // assert
    expect(result, Right(debeHeaders));
    verify(mockDebeRepository.getDebeHeaders());
    verifyNoMoreInteractions(mockDebeRepository);
  });
}