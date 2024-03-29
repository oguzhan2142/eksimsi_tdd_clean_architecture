// Mocks generated by Mockito 5.0.15 from annotations
// in eksimsi_tdd_clean_architecture/test/features/entries/domain/usecases/get_agenda_entries_page_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:eksimsi_tdd_clean_architecture/core/error/failures.dart' as _i5;
import 'package:eksimsi_tdd_clean_architecture/core/parameters/href_page_parameter.dart'
    as _i8;
import 'package:eksimsi_tdd_clean_architecture/features/entries/domain/entities/entries_page.dart'
    as _i6;
import 'package:eksimsi_tdd_clean_architecture/features/entries/domain/repositories/entries_repository.dart'
    as _i3;
import 'package:eksimsi_tdd_clean_architecture/features/entries/domain/usecases/get_agenda_entries_page.dart'
    as _i7;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeEither_0<L, R> extends _i1.Fake implements _i2.Either<L, R> {}

class _FakeEntriesRepository_1 extends _i1.Fake
    implements _i3.EntriesRepository {}

/// A class which mocks [EntriesRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockEntriesRepository extends _i1.Mock implements _i3.EntriesRepository {
  MockEntriesRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.EntriesPage>> getAgendaEntriesPage(
          String? url, int? page) =>
      (super.noSuchMethod(Invocation.method(#getAgendaEntriesPage, [url, page]),
          returnValue: Future<_i2.Either<_i5.Failure, _i6.EntriesPage>>.value(
              _FakeEither_0<_i5.Failure, _i6.EntriesPage>())) as _i4
          .Future<_i2.Either<_i5.Failure, _i6.EntriesPage>>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [GetAgendaEntriesPage].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetAgendaEntriesPage extends _i1.Mock
    implements _i7.GetAgendaEntriesPage {
  MockGetAgendaEntriesPage() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.EntriesRepository get agendaRepository =>
      (super.noSuchMethod(Invocation.getter(#agendaRepository),
          returnValue: _FakeEntriesRepository_1()) as _i3.EntriesRepository);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.EntriesPage>> call(
          {_i8.HrefPageParameter? parameter}) =>
      (super.noSuchMethod(Invocation.method(#call, [], {#parameter: parameter}),
          returnValue: Future<_i2.Either<_i5.Failure, _i6.EntriesPage>>.value(
              _FakeEither_0<_i5.Failure, _i6.EntriesPage>())) as _i4
          .Future<_i2.Either<_i5.Failure, _i6.EntriesPage>>);
  @override
  String toString() => super.toString();
}
