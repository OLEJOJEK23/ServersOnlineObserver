import 'package:dartz/dartz.dart';
import 'package:servers_online_observer/api/domain/entities/online.dart';

import '../../core/error/Failure.dart';

abstract class OnlineRepository {
  Future<Either<Failure, List<Online>>> getCurrentOnline();
}
