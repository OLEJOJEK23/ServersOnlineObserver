class Player {
  Player({
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
}
