import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:servers_online_observer/api/domain/entities/server_details.dart';
import 'package:servers_online_observer/api/domain/usecases/get_players.dart';
import 'package:servers_online_observer/widgets/player_list_table.dart';

import '../api/domain/entities/player.dart';

class ServerPlayersBottomSheet extends StatefulWidget {
  final String serverID;

  const ServerPlayersBottomSheet({
    super.key,
    required this.serverID,
  });

  @override
  State<ServerPlayersBottomSheet> createState() =>
      _ServerPlayersBottomSheetState();
}

class _ServerPlayersBottomSheetState extends State<ServerPlayersBottomSheet> {
  final GetPlayers _getPlayers = GetIt.I<GetPlayers>();
  List<Player> _players = [];
  late ServerDetails _serverDetails;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    _fetchPlayers();
    super.initState();
  }

  Future<void> _fetchPlayers() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    final result = await _getPlayers(serverId: widget.serverID);
    result.fold(
      (failure) => setState(() {
        _error = failure.message;
        _isLoading = false;
      }),
      (data) => setState(() {
        _players = data.players;
        _serverDetails = data.serverDetails;
        _isLoading = false;
      }),
    );
    if (_error != null) {
      print(_error);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(28),
                ),
              ),
              child: Column(
                children: [
                  // Header
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 20, 24, 12),
                    child: Row(
                      children: [
                        Icon(Icons.people_rounded,
                            color: colorScheme.primary, size: 28),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _serverDetails.serverName,
                                style: theme.textTheme.titleLarge
                                    ?.copyWith(fontWeight: FontWeight.w600),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                "Карта: ${_serverDetails.currentMap} • Онлайн: ${_serverDetails.playersOnline}",
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close_rounded),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  ),

                  // Score
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    color: colorScheme.surfaceContainerHighest,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(_serverDetails.tScore.toString(),
                            style: const TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.orange)),
                        const SizedBox(width: 32),
                        Text(":",
                            style: TextStyle(
                                fontSize: 32,
                                color: colorScheme.onSurfaceVariant)),
                        const SizedBox(width: 32),
                        Text(_serverDetails.ctScore.toString(),
                            style: const TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue)),
                      ],
                    ),
                  ),
                  
                  // Admins online
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    child: Text(
                      "Админов на сервере: ${_serverDetails.adminsOnline}",
                      style: theme.textTheme.titleMedium,
                    ),
                  ),

                  // Player List Table
                  Expanded(
                    child: PlayerListTable(players: _players),
                  ),

                  // Bottom Buttons
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            icon: const Icon(Icons.copy),
                            label: const Text('Скопировать IP'),
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('IP скопирован в буфер'),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: FilledButton.icon(
                            icon: const Icon(Icons.play_arrow_rounded),
                            label: const Text('Присоединиться'),
                            onPressed: () {
                              // TODO: connection logic
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
