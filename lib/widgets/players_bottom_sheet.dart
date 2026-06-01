import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:servers_online_observer/api/domain/entities/server_details.dart';
import 'package:servers_online_observer/api/domain/usecases/get_players.dart';

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
  bool _isLoading = false;
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
      (players) => setState(() {
        _players = players.players;
        _serverDetails = players.serverDetails;
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
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Заголовок
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
                                "Карта: ${_serverDetails.currentMap} • ${_serverDetails.playersOnline}/${_serverDetails.adminsOnline}",
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

                  // Счёт команд
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

                  // Таблица игроков с анимацией
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      itemCount: _players.length,
                      itemBuilder: (context, index) {
                        final player = _players[index];
                        final isTerrorist = player.team == "Terrorist";
                        return TweenAnimationBuilder<double>(
                          tween: Tween(begin: 0.0, end: 1.0),
                          duration: Duration(milliseconds: 300 + index * 60),
                          curve: Curves.easeOutCubic,
                          builder: (context, value, child) {
                            return Opacity(
                              opacity: value,
                              child: Transform.translate(
                                offset: Offset(0, 30 * (1 - value)),
                                child: child,
                              ),
                            );
                          },
                          child: Card(
                            margin: const EdgeInsets.only(bottom: 8),
                            color: isTerrorist
                                ? Colors.orange.withValues(alpha: 0.12)
                                : Colors.blue.withValues(alpha: 0.12),
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              leading: CircleAvatar(
                                backgroundColor:
                                    isTerrorist ? Colors.orange : Colors.blue,
                                child: Text(
                                  isTerrorist ? "T" : "CT",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              title: Text(
                                player.playerName,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600),
                              ),
                              subtitle: Row(
                                children: [
                                  Text("RANK"),
                                  const SizedBox(width: 12),
                                  Text(
                                    "HS: ${player.hsPercent}%",
                                    style: TextStyle(
                                      color: colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                ],
                              ),
                              trailing: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${player.kills}",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    "${player.kdRatio} K/D",
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  // Нижние кнопки
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
                              // TODO: логика подключения
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
