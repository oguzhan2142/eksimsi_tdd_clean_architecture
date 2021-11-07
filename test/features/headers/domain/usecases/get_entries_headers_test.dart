import 'package:dartz/dartz.dart';
import 'package:eksimsi_tdd_clean_architecture/core/parameters/href_parameter.dart';
import 'package:eksimsi_tdd_clean_architecture/features/headers/domain/entities/header.dart';
import 'package:eksimsi_tdd_clean_architecture/features/headers/domain/repositories/headers_repository.dart';
import 'package:eksimsi_tdd_clean_architecture/features/headers/domain/usecases/get_entries_headers.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_entries_headers_test.mocks.dart';




@GenerateMocks([HeadersRepository])
void main() {
  late GetEntriesHeaders usecase;
  late MockHeadersRepository repository;

  setUp(() {
    repository = MockHeadersRepository();
    usecase = GetEntriesHeaders(repository);
  });

  final agendaHeaders = <Header>[
    Header(title: 'test', href: 'test href', entryAmount: '1'),
  ];

  test('should call agenda_repository when execute usecase', () async {
    when(repository.getHeaders(href: anyNamed('href'))).thenAnswer((_) async => Right(agendaHeaders));

    final result = await usecase.call(parameter: HrefParameter(href: ''));

    expect(result, Right(agendaHeaders));
    verify(repository.getHeaders(href: anyNamed('href')));
    verifyNoMoreInteractions(repository);
  });
}
