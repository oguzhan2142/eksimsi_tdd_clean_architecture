import 'package:dartz/dartz.dart';
import 'package:eksimsi_tdd_clean_architecture/core/error/exception.dart';
import 'package:eksimsi_tdd_clean_architecture/core/error/failures.dart';
import 'package:eksimsi_tdd_clean_architecture/core/platform/network_info.dart';
import 'package:eksimsi_tdd_clean_architecture/features/entries/data/datasources/entries_repository_remote_data_source.dart';
import 'package:eksimsi_tdd_clean_architecture/features/entries/domain/entities/entries_page.dart';
import 'package:eksimsi_tdd_clean_architecture/features/entries/domain/entities/header.dart';
import 'package:eksimsi_tdd_clean_architecture/features/entries/domain/repositories/agenda_repository.dart';

class AgendaRepositoryImp extends AgendaRepository {
  final EntriesRepositoryRemoteDataSource entriesRepositoryRemoteDataSource;
  final NetworkInfo networkInfo;

  AgendaRepositoryImp({
    required this.entriesRepositoryRemoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, EntriesPage>> getAgendaEntriesPage(
    String url,
    int? page,
  ) async {
    networkInfo.isConnected;
    final model = await entriesRepositoryRemoteDataSource.getEntriesPage(
      href: url,
      page: page,
    );
    return Right(model);
  }

  @override
  Future<Either<Failure, List<Header>>> getHeaders() async {
    try {
      if (!await networkInfo.isConnected) throw NoInternetException();

      final headers = await entriesRepositoryRemoteDataSource.getHeaders();

      return Right(headers);
    } on ServerException {
      return Left(ServerFailure());
    } on NoInternetException {
      return Left(NoInternetFailure());
    }
  }
}
