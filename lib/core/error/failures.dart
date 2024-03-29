import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

class ServerFailure extends Failure {
  @override
  List<Object?> get props => [];
}


class NoInternetFailure extends Failure{
  @override
  List<Object?> get props => [];
}

class URIFailure extends Failure{
  @override
  List<Object?> get props => [];
}

class NullDataFailure extends Failure{
  @override

  List<Object?> get props => throw UnimplementedError();
}
