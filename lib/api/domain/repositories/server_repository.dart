import 'package:dartz/dartz.dart';
import 'package:servers_online_observer/api/core/error/failure.dart';

import '../entities/server.dart';

abstract class ServerRepository {
  Future<Either<Failure, List<Server>>> getServers();
}
