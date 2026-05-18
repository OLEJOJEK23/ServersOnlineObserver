// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServersResponse _$ServersResponseFromJson(Map<String, dynamic> json) =>
    ServersResponse(
      servers: (json['servers'] as List<dynamic>)
          .map((e) => ServerDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ServersResponseToJson(ServersResponse instance) =>
    <String, dynamic>{
      'servers': instance.servers,
    };

ServerDto _$ServerDtoFromJson(Map<String, dynamic> json) => ServerDto(
      serverId: json['serverId'] as String,
      serverName: json['serverName'] as String,
      serverCurrentMap: json['serverCurrentMap'] as String,
      serverCurrentOnline: json['serverCurrentOnline'] as String,
      serverIP: json['serverIP'] as String,
    );

Map<String, dynamic> _$ServerDtoToJson(ServerDto instance) => <String, dynamic>{
      'serverId': instance.serverId,
      'serverName': instance.serverName,
      'serverCurrentMap': instance.serverCurrentMap,
      'serverCurrentOnline': instance.serverCurrentOnline,
      'serverIP': instance.serverIP,
    };
