import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'core/platform/network_info.dart';
import 'features/agenda/data/datasources/agenda_repository_remote_data_source.dart';
import 'features/agenda/data/repositories/agenda_repository_impl.dart';
import 'features/agenda/domain/repositories/agenda_repository.dart';
import 'features/agenda/domain/usecases/get_agenda_entries_page.dart';
import 'features/agenda/domain/usecases/get_agenda_headers.dart';
import 'features/agenda/presentation/blocs/entry_page_bloc/entry_page_bloc.dart';
import 'features/agenda/presentation/blocs/headers_bloc/headers_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void init() {
  // Features

  sl.registerFactory(() => HeadersBloc(getAgendaHeaders: sl()));
  sl.registerFactory(() => EntryPageBloc(getAgendaEntriesPage: sl()));

  sl.registerLazySingleton(() => GetAgendaHeaders(sl()));
  sl.registerLazySingleton(() => GetAgendaEntriesPage(sl()));

  sl.registerLazySingleton<AgendaRepository>(() => AgendaRepositoryImp(
      agendaRepositoryRemoteDataSource: sl(), networkInfo: sl()));

  sl.registerLazySingleton<AgendaRepositoryRemoteDataSource>(
      () => AgendaRepositoryRemoteDataSourceImpl(client: sl()));

  // Core
  sl.registerLazySingleton<Dio>(() => Dio());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // External

  sl.registerLazySingleton(() => Connectivity());
}
