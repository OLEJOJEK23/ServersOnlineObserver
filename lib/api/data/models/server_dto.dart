import 'package:json_annotation/json_annotation.dart';
import 'package:servers_online_observer/api/domain/entities/server.dart';

part 'server_dto.g.dart';

@JsonSerializable()
class ServersResponse {
  final List<ServerDto> servers;

  ServersResponse({required this.servers});

  factory ServersResponse.fromJson(Map<String, dynamic> json) =>
      _$ServersResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ServersResponseToJson(this);
}

@JsonSerializable()
class ServerDto {
  ServerDto({
    required this.serverId,
    required this.serverName,
    required this.serverCurrentMap,
    required this.serverCurrentOnline,
    required this.serverIP,
  });

  final String serverId;
  final String serverName;
  final String serverCurrentMap;
  final String serverCurrentOnline;
  final String serverIP;

  factory ServerDto.fromJson(Map<String, dynamic> json) =>
      _$ServerDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ServerDtoToJson(this);

  Server toDomain() => Server(
        serverId: serverId,
        serverName: serverName,
        serverCurrentMap: serverCurrentMap,
        serverCurrentOnline: serverCurrentOnline,
        serverIP: serverIP,
      );
}
