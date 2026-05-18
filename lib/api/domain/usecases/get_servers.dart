import 'package:dartz/dartz.dart';
import 'package:servers_online_observer/api/core/error/failure.dart';
import 'package:servers_online_observer/api/domain/repositories/server_repository.dart';

import '../entities/server.dart';

class GetServers {
  final ServerRepository repository;

  GetServers(this.repository);

  Future<Either<Failure, List<Server>>> call() async {
    return await repository.getServers();
  }
}
