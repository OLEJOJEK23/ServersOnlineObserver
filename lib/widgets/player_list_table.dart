import 'package:flutter/material.dart';
import '../api/domain/entities/player.dart';

class PlayerListTable extends StatelessWidget {
  final List<Player> players;

  const PlayerListTable({super.key, required this.players});

  @override
  Widget build(BuildContext context) {
    if (players.isEmpty) {
      return const Center(
        child: Text(
          "Сервер пуст",
          style: TextStyle(fontSize: 18),
        ),
      );
    }

    return Column(
      children: [
        _buildHeader(context),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            itemCount: players.length,
            itemBuilder: (context, index) {
              return _buildPlayerRow(players[index], context);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      margin: const EdgeInsets.symmetric(horizontal: 12.0),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: Row(
        children: [
          _buildCell(const Text('LVL'), flex: 2),
          _buildCell(const Text('Игрок'), flex: 6),
          _buildCell(const Text('Звание'), flex: 5, alignment: Alignment.center),
          _buildCell(const Text('Киллы'), flex: 3, alignment: Alignment.center),
          _buildCell(const Text('K/D'), flex: 3, alignment: Alignment.center),
          _buildCell(const Text('HS%'), flex: 3, alignment: Alignment.center),
          _buildCell(const Text('Время'), flex: 4, alignment: Alignment.center),
          _buildCell(const Text('Пинг'), flex: 2, alignment: Alignment.centerRight),
        ],
      ),
    );
  }

  Widget _buildPlayerRow(Player player, BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final isTerrorist = player.team == "Terrorist";
    final startColor = isTerrorist ? Colors.orange : Colors.blue;
    final endColor = isDarkMode ? Colors.black.withOpacity(0.4) : Colors.white.withOpacity(0.4);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        gradient: LinearGradient(
          colors: [startColor.withOpacity(0.6), endColor],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          stops: const [0.0, 0.7], // Gradient stops around the "Kills" column
        ),
      ),
      child: Row(
        children: [
          _buildCell(Text(player.faceitLevel.toString()), flex: 2),
          _buildCell(
            Text(
              player.playerName,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            flex: 6,
          ),
          _buildCell(
            Image.network(player.rankImageUrl, width: 60, height: 20, fit: BoxFit.contain),
            flex: 5,
            alignment: Alignment.center,
          ),
          _buildCell(
            Text(player.kills.toString()),
            flex: 3,
            alignment: Alignment.center,
          ),
          _buildCell(
            Text(player.kdRatio.toString()),
            flex: 3,
            alignment: Alignment.center,
          ),
          _buildCell(
            Text('${player.hsPercent}%'),
            flex: 3,
            alignment: Alignment.center,
          ),
          _buildCell(
            Text(player.timeInGame),
            flex: 4,
            alignment: Alignment.center,
          ),
          _buildCell(
            Text(player.ping.toString()),
            flex: 2,
            alignment: Alignment.centerRight,
          ),
        ],
      ),
    );
  }

  Widget _buildCell(Widget child, {required int flex, Alignment alignment = Alignment.centerLeft}) {
    return Expanded(
      flex: flex,
      child: Container(
        alignment: alignment,
        child: child,
      ),
    );
  }
}
