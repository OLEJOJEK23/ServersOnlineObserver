import 'package:servers_online_observer/api/domain/entities/player.dart';
import 'package:servers_online_observer/api/domain/entities/server_details.dart';

class ServerPlayersResponse {
  final ServerDetails serverDetails;
  final List<Player> players;

  ServerPlayersResponse({required this.serverDetails, required this.players});
}
