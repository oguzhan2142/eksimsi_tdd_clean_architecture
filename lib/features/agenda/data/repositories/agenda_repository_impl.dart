import 'package:dartz/dartz.dart';

import 'package:eksimsi_tdd_clean_architecture/core/error/failures.dart';
import 'package:eksimsi_tdd_clean_architecture/core/platform/network_info.dart';
import 'package:eksimsi_tdd_clean_architecture/features/agenda/data/datasources/agenda_repository_remote_data_source.dart';
import 'package:eksimsi_tdd_clean_architecture/features/agenda/domain/entities/agenda_header.dart';
import 'package:eksimsi_tdd_clean_architecture/features/agenda/domain/entities/entries_page.dart';
import 'package:eksimsi_tdd_clean_architecture/features/agenda/domain/repositories/agenda_repository.dart';

class AgendaRepositoryImp extends AgendaRepository {
  final AgendaRepositoryRemoteDataSource agendaRepositoryRemoteDataSource;
  final NetworkInfo networkInfo;

  AgendaRepositoryImp({
    required this.agendaRepositoryRemoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, AgendaEntriesPage>> getAgendaEntriesPage() {
    networkInfo.isConnected;
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<AgendaHeader>>> getAgendaHeaders() async {
    networkInfo.isConnected;

    final headers = await agendaRepositoryRemoteDataSource.getAgendaHeaders();
    return Right(headers);
  }
}
