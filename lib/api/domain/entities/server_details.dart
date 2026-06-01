class ServerDetails {
  final String playersOnline;
  final String adminsOnline;
  final String serverName;
  final String currentMap;
  final String leadingTeamStatus;
  final int ctScore;
  final int tScore;

  ServerDetails({
    required this.playersOnline,
    required this.adminsOnline,
    required this.serverName,
    required this.currentMap,
    required this.leadingTeamStatus,
    required this.ctScore,
    required this.tScore,
  });
}
