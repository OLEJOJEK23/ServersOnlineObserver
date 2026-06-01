import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:servers_online_observer/api/core/error/failure.dart';
import 'package:servers_online_observer/api/data/sources/remote/api_service.dart';
import 'package:servers_online_observer/api/domain/entities/server_players_response.dart';
import 'package:servers_online_observer/api/domain/repositories/server_repository.dart';

import '../../domain/entities/server.dart';
import '../models/server_dto.dart';
import '../sources/local/cache_manager.dart';

class ServerRepositoryImpl implements ServerRepository {
  ServerRepositoryImpl({required this.apiService, required this.cacheManager});

  final ApiService apiService;
  final CacheManager cacheManager;

  @override
  Future<Either<Failure, List<Server>>> getServers() async {
    try {
      final cachedData = await cacheManager.getData('servers');
      if (cachedData != null) {
        return Right((cachedData as List)
            .map((e) => ServerDto.fromJson(e).toDomain())
            .toList());
      }

      final response = await apiService.getServers();
      final servers = response.servers.map((dto) => dto.toDomain()).toList();

      await cacheManager.saveData(
        "servers",
        response.servers.map((e) => e.toJson()).toList(),
      );

      return Right(servers);
    } on DioException catch (e) {
      return Left(ServerFailure("API error: ${e.message}"));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, ServerPlayersResponse>> getPlayers(
      {required String serverId}) async {
    try {
      // Caching for players is not implemented in this example
      final response = await apiService.getPlayers(serverId: serverId);
      return Right(response.toDomain());
    } on DioException catch (e) {
      return Left(ServerFailure("API error: ${e.message}"));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }
}
