// Mocks generated by Mockito 5.0.15 from annotations
// in eksimsi_tdd_clean_architecture/test/features/headers/presentation/bloc/headers_bloc_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i5;

import 'package:dartz/dartz.dart' as _i3;
import 'package:eksimsi_tdd_clean_architecture/core/error/failures.dart' as _i6;
import 'package:eksimsi_tdd_clean_architecture/core/parameters/parameter.dart'
    as _i10;
import 'package:eksimsi_tdd_clean_architecture/features/headers/domain/entities/channel_header.dart'
    as _i9;
import 'package:eksimsi_tdd_clean_architecture/features/headers/domain/entities/header.dart'
    as _i7;
import 'package:eksimsi_tdd_clean_architecture/features/headers/domain/repositories/headers_repository.dart'
    as _i2;
import 'package:eksimsi_tdd_clean_architecture/features/headers/domain/usecases/get_channel_headers.dart'
    as _i8;
import 'package:eksimsi_tdd_clean_architecture/features/headers/domain/usecases/get_headers.dart'
    as _i4;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeHeadersRepository_0 extends _i1.Fake
    implements _i2.HeadersRepository {}

class _FakeEither_1<L, R> extends _i1.Fake implements _i3.Either<L, R> {}

/// A class which mocks [GetAgendaHeaders].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetAgendaHeaders extends _i1.Mock implements _i4.GetAgendaHeaders {
  MockGetAgendaHeaders() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.HeadersRepository get agendaRepository =>
      (super.noSuchMethod(Invocation.getter(#agendaRepository),
          returnValue: _FakeHeadersRepository_0()) as _i2.HeadersRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i7.Header>>> call() =>
      (super.noSuchMethod(Invocation.method(#call, []),
          returnValue: Future<_i3.Either<_i6.Failure, List<_i7.Header>>>.value(
              _FakeEither_1<_i6.Failure, List<_i7.Header>>())) as _i5
          .Future<_i3.Either<_i6.Failure, List<_i7.Header>>>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [GetChannelHeaders].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetChannelHeaders extends _i1.Mock implements _i8.GetChannelHeaders {
  MockGetChannelHeaders() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.HeadersRepository get channelRepository =>
      (super.noSuchMethod(Invocation.getter(#channelRepository),
          returnValue: _FakeHeadersRepository_0()) as _i2.HeadersRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i9.ChannelHeader>>> call(
          {_i10.NoParameter? parameter}) =>
      (super.noSuchMethod(Invocation.method(#call, [], {#parameter: parameter}),
          returnValue:
              Future<_i3.Either<_i6.Failure, List<_i9.ChannelHeader>>>.value(
                  _FakeEither_1<_i6.Failure, List<_i9.ChannelHeader>>())) as _i5
          .Future<_i3.Either<_i6.Failure, List<_i9.ChannelHeader>>>);
  @override
  String toString() => super.toString();
}
