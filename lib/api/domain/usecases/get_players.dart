import 'package:dartz/dartz.dart';
import 'package:servers_online_observer/api/core/error/failure.dart';
import 'package:servers_online_observer/api/domain/entities/server_players_response.dart';
import 'package:servers_online_observer/api/domain/repositories/server_repository.dart';

class GetPlayers {
  final ServerRepository repository;

  GetPlayers(this.repository);

  Future<Either<Failure, ServerPlayersResponse>> call({
    required String serverId,
  }) async {
    return await repository.getPlayers(serverId: serverId);
  }
}
