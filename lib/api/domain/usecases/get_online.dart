import 'package:dartz/dartz.dart';
import 'package:servers_online_observer/api/domain/entities/online.dart';
import 'package:servers_online_observer/api/domain/repositories/online_repository.dart';

import '../../core/error/Failure.dart';

class GetOnline {
  final OnlineRepository repository;

  GetOnline(this.repository);

  Future<Either<Failure, List<Online>>> call() async {
    return await repository.getCurrentOnline();
  }
}
