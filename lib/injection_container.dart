import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:eksimsi_tdd_clean_architecture/features/headers/domain/usecases/get_channel_headers.dart';
import 'package:get_it/get_it.dart';

import 'core/platform/network_info.dart';
import 'features/entries/data/datasources/entries_repository_remote_data_source.dart';
import 'features/entries/data/repositories/entries_repository_impl.dart';
import 'features/entries/domain/repositories/entries_repository.dart';
import 'features/entries/domain/usecases/get_agenda_entries_page.dart';
import 'features/entries/presentation/blocs/entry_page_bloc/entry_page_bloc.dart';
import 'features/headers/domain/usecases/get_entries_headers.dart';
import 'features/headers/presentation/bloc/headers_bloc/headers_bloc.dart';

final sl = GetIt.instance;

void init() {
  // Features

  sl.registerFactory(
    () => HeadersBloc(getAgendaHeaders: sl(), getChannelHeaders: sl()),
  );
  sl.registerFactory(() => EntryPageBloc(getAgendaEntriesPage: sl()));


  sl.registerLazySingleton(() => GetChannelHeaders(channelRepository: sl()));
  sl.registerLazySingleton(() => GetEntriesHeaders(sl()));
  sl.registerLazySingleton(() => GetAgendaEntriesPage(sl()));

  sl.registerLazySingleton<EntriesRepository>(
    () => EntriesRepositoryImp(
      entriesRepositoryRemoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<EntriesRepositoryRemoteDataSource>(
    () => EntriesRepositoryRemoteDataSourceImpl(client: sl()),
  );

  // Core
  sl.registerLazySingleton<Dio>(() => Dio());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // External
  sl.registerLazySingleton(() => Connectivity());
}
