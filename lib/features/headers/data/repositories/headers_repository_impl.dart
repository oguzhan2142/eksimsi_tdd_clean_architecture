import 'package:dartz/dartz.dart';
import 'package:eksimsi_tdd_clean_architecture/core/error/exception.dart';
import 'package:eksimsi_tdd_clean_architecture/core/error/failures.dart';
import 'package:eksimsi_tdd_clean_architecture/core/platform/network_info.dart';
import 'package:eksimsi_tdd_clean_architecture/features/headers/data/datasources/headers_repository_remote_data_source.dart';
import 'package:eksimsi_tdd_clean_architecture/features/headers/domain/entities/channel_header.dart';
import 'package:eksimsi_tdd_clean_architecture/features/headers/domain/entities/header.dart';
import 'package:eksimsi_tdd_clean_architecture/features/headers/domain/repositories/headers_repository.dart';

class HeadersRepositoryImpl extends HeadersRepository {
  final NetworkInfo networkInfo;
  final HeadersRepositoryRemoteDataSource remoteDataSource;

  HeadersRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
  });



  @override
  Future<Either<Failure, List<ChannelHeader>>> getChannelHeaders() {

    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Header>>> getHeaders({required String href}) async{
   try {
      if (!await networkInfo.isConnected) throw NoInternetException();

      final headers = await remoteDataSource.getHeaders(href: href);

      return Right(headers);
    } on ServerException {
      return Left(ServerFailure());
    } on NoInternetException {
      return Left(NoInternetFailure());
    }
  }
}
