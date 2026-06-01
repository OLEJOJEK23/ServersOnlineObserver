// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'players_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServerPlayersResponseDto _$ServerPlayersResponseDtoFromJson(
        Map<String, dynamic> json) =>
    ServerPlayersResponseDto(
      serverDetails: ServerDetailsDto.fromJson(
          json['serverDetails'] as Map<String, dynamic>),
      players: (json['players'] as List<dynamic>)
          .map((e) => PlayerDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ServerPlayersResponseDtoToJson(
        ServerPlayersResponseDto instance) =>
    <String, dynamic>{
      'serverDetails': instance.serverDetails,
      'players': instance.players,
    };

ServerDetailsDto _$ServerDetailsDtoFromJson(Map<String, dynamic> json) =>
    ServerDetailsDto(
      playersOnline: json['playersOnline'] as String,
      adminsOnline: json['adminsOnline'] as String,
      serverName: json['serverName'] as String,
      currentMap: json['currentMap'] as String,
      leadingTeamStatus: json['leadingTeamStatus'] as String,
      ctScore: (json['ctScore'] as num).toInt(),
      tScore: (json['tScore'] as num).toInt(),
    );

Map<String, dynamic> _$ServerDetailsDtoToJson(ServerDetailsDto instance) =>
    <String, dynamic>{
      'playersOnline': instance.playersOnline,
      'adminsOnline': instance.adminsOnline,
      'serverName': instance.serverName,
      'currentMap': instance.currentMap,
      'leadingTeamStatus': instance.leadingTeamStatus,
      'ctScore': instance.ctScore,
      'tScore': instance.tScore,
    };

PlayerDto _$PlayerDtoFromJson(Map<String, dynamic> json) => PlayerDto(
      steamId: json['steamId'] as String,
      team: json['team'] as String,
      faceitLevel: (json['faceitLevel'] as num).toInt(),
      playerName: json['playerName'] as String,
      hasPrime: json['hasPrime'] as bool,
      isAdmin: json['isAdmin'] as bool,
      vipStatus: json['vipStatus'] as String?,
      rankImageUrl: json['rankImageUrl'] as String,
      kills: (json['kills'] as num).toInt(),
      kdRatio: (json['kdRatio'] as num).toDouble(),
      hsPercent: (json['hsPercent'] as num).toInt(),
      timeInGame: json['timeInGame'] as String,
      ping: (json['ping'] as num).toInt(),
    );

Map<String, dynamic> _$PlayerDtoToJson(PlayerDto instance) => <String, dynamic>{
      'steamId': instance.steamId,
      'team': instance.team,
      'faceitLevel': instance.faceitLevel,
      'playerName': instance.playerName,
      'hasPrime': instance.hasPrime,
      'isAdmin': instance.isAdmin,
      'vipStatus': instance.vipStatus,
      'rankImageUrl': instance.rankImageUrl,
      'kills': instance.kills,
      'kdRatio': instance.kdRatio,
      'hsPercent': instance.hsPercent,
      'timeInGame': instance.timeInGame,
      'ping': instance.ping,
    };
