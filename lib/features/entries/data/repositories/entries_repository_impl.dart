import 'package:dartz/dartz.dart';
import 'package:eksimsi_tdd_clean_architecture/core/error/failures.dart';
import 'package:eksimsi_tdd_clean_architecture/core/platform/network_info.dart';
import 'package:eksimsi_tdd_clean_architecture/features/entries/data/datasources/entries_repository_remote_data_source.dart';
import 'package:eksimsi_tdd_clean_architecture/features/entries/domain/entities/entries_page.dart';
import 'package:eksimsi_tdd_clean_architecture/features/entries/domain/repositories/entries_repository.dart';

class AgendaRepositoryImp extends EntriesRepository {
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

 
}
