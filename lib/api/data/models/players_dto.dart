import 'package:json_annotation/json_annotation.dart';
import 'package:servers_online_observer/api/domain/entities/player.dart';
import 'package:servers_online_observer/api/domain/entities/server_details.dart';
import 'package:servers_online_observer/api/domain/entities/server_players_response.dart';

part 'players_dto.g.dart';

@JsonSerializable()
class ServerPlayersResponseDto {
  final ServerDetailsDto serverDetails;
  final List<PlayerDto> players;

  ServerPlayersResponseDto({required this.serverDetails, required this.players});

  factory ServerPlayersResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ServerPlayersResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ServerPlayersResponseDtoToJson(this);

  ServerPlayersResponse toDomain() => ServerPlayersResponse(
        serverDetails: serverDetails.toDomain(),
        players: players.map((p) => p.toDomain()).toList(),
      );
}

@JsonSerializable()
class ServerDetailsDto {
  final String playersOnline;
  final String adminsOnline;
  final String serverName;
  final String currentMap;
  final String leadingTeamStatus;
  final int ctScore;
  final int tScore;

  ServerDetailsDto({
    required this.playersOnline,
    required this.adminsOnline,
    required this.serverName,
    required this.currentMap,
    required this.leadingTeamStatus,
    required this.ctScore,
    required this.tScore,
  });

  factory ServerDetailsDto.fromJson(Map<String, dynamic> json) =>
      _$ServerDetailsDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ServerDetailsDtoToJson(this);

  ServerDetails toDomain() => ServerDetails(
        playersOnline: playersOnline,
        adminsOnline: adminsOnline,
        serverName: serverName,
        currentMap: currentMap,
        leadingTeamStatus: leadingTeamStatus,
        ctScore: ctScore,
        tScore: tScore,
      );
}

@JsonSerializable()
class PlayerDto {
  final String steamId;
  final String team;
  final int faceitLevel;
  final String playerName;
  final bool hasPrime;
  final bool isAdmin;
  final String? vipStatus;
  final String rankImageUrl;
  final int kills;
  final double kdRatio;
  final int hsPercent;
  final String timeInGame;
  final int ping;

  PlayerDto({
    required this.steamId,
    required this.team,
    required this.faceitLevel,
    required this.playerName,
    required this.hasPrime,
    required this.isAdmin,
    this.vipStatus,
    required this.rankImageUrl,
    required this.kills,
    required this.kdRatio,
    required this.hsPercent,
    required this.timeInGame,
    required this.ping,
  });

  factory PlayerDto.fromJson(Map<String, dynamic> json) =>
      _$PlayerDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PlayerDtoToJson(this);

  Player toDomain() => Player(
        steamId: steamId,
        team: team,
        faceitLevel: faceitLevel,
        playerName: playerName,
        hasPrime: hasPrime,
        isAdmin: isAdmin,
        vipStatus: vipStatus,
        rankImageUrl: rankImageUrl,
        kills: kills,
        kdRatio: kdRatio,
        hsPercent: hsPercent,
        timeInGame: timeInGame,
        ping: ping,
      );
}
