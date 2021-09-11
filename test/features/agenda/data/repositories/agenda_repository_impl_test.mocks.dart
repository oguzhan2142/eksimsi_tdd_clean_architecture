// Mocks generated by Mockito 5.0.15 from annotations
// in eksimsi_tdd_clean_architecture/test/features/agenda/data/repositories/agenda_repository_impl_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:eksimsi_tdd_clean_architecture/core/platform/network_info.dart'
    as _i6;
import 'package:eksimsi_tdd_clean_architecture/features/agenda/data/datasources/agenda_repository_remote_data_source.dart'
    as _i3;
import 'package:eksimsi_tdd_clean_architecture/features/agenda/data/models/agenda_header_model.dart'
    as _i5;
import 'package:eksimsi_tdd_clean_architecture/features/agenda/data/models/entries_page_model.dart'
    as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeAgendaEntriesPageModel_0 extends _i1.Fake
    implements _i2.AgendaEntriesPageModel {}

/// A class which mocks [AgendaRepositoryRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockAgendaRepositoryRemoteDataSource extends _i1.Mock
    implements _i3.AgendaRepositoryRemoteDataSource {
  MockAgendaRepositoryRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.AgendaEntriesPageModel> getAgendaEntriesPage(String? url) =>
      (super.noSuchMethod(Invocation.method(#getAgendaEntriesPage, [url]),
              returnValue: Future<_i2.AgendaEntriesPageModel>.value(
                  _FakeAgendaEntriesPageModel_0()))
          as _i4.Future<_i2.AgendaEntriesPageModel>);
  @override
  _i4.Future<List<_i5.AgendaHeaderModel>> getAgendaHeaders() =>
      (super.noSuchMethod(Invocation.method(#getAgendaHeaders, []),
              returnValue: Future<List<_i5.AgendaHeaderModel>>.value(
                  <_i5.AgendaHeaderModel>[]))
          as _i4.Future<List<_i5.AgendaHeaderModel>>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [NetworkInfo].
///
/// See the documentation for Mockito's code generation for more information.
class MockNetworkInfo extends _i1.Mock implements _i6.NetworkInfo {
  MockNetworkInfo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<bool> get isConnected =>
      (super.noSuchMethod(Invocation.getter(#isConnected),
          returnValue: Future<bool>.value(false)) as _i4.Future<bool>);
  @override
  String toString() => super.toString();
}
