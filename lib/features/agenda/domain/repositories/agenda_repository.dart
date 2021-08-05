import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/agenda_header.dart';

abstract class AgendaRepository {

  Future<Either<Failure,AgendaHeader>> getAgendaHeaders();

  
  
}