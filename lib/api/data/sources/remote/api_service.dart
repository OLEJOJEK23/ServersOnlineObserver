import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:servers_online_observer/api/data/sources/remote/endpoints.dart';

import '../../models/players_dto.dart';
import '../../models/server_dto.dart';

part 'api_service.g.dart';

@RestApi()
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET(Endpoints.getServers)
  Future<ServersResponse> getServers();

  @GET(Endpoints.getPlayers)
  Future<ServerPlayersResponseDto> getPlayers({
    @Query('server_id') required String serverId,
  });
}
