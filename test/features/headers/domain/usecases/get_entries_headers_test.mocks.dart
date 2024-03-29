// Mocks generated by Mockito 5.0.15 from annotations
// in eksimsi_tdd_clean_architecture/test/features/headers/domain/usecases/get_entries_headers_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:eksimsi_tdd_clean_architecture/core/error/failures.dart' as _i5;
import 'package:eksimsi_tdd_clean_architecture/features/headers/domain/entities/channel_header.dart'
    as _i7;
import 'package:eksimsi_tdd_clean_architecture/features/headers/domain/entities/header.dart'
    as _i6;
import 'package:eksimsi_tdd_clean_architecture/features/headers/domain/repositories/headers_repository.dart'
    as _i3;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeEither_0<L, R> extends _i1.Fake implements _i2.Either<L, R> {}

/// A class which mocks [HeadersRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockHeadersRepository extends _i1.Mock implements _i3.HeadersRepository {
  MockHeadersRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i6.Header>>> getHeaders(
          {String? href}) =>
      (super.noSuchMethod(Invocation.method(#getHeaders, [], {#href: href}),
          returnValue: Future<_i2.Either<_i5.Failure, List<_i6.Header>>>.value(
              _FakeEither_0<_i5.Failure, List<_i6.Header>>())) as _i4
          .Future<_i2.Either<_i5.Failure, List<_i6.Header>>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i7.ChannelHeader>>>
      getChannelHeaders() => (super.noSuchMethod(
          Invocation.method(#getChannelHeaders, []),
          returnValue:
              Future<_i2.Either<_i5.Failure, List<_i7.ChannelHeader>>>.value(
                  _FakeEither_0<_i5.Failure, List<_i7.ChannelHeader>>())) as _i4
          .Future<_i2.Either<_i5.Failure, List<_i7.ChannelHeader>>>);
  @override
  String toString() => super.toString();
}
