import 'package:flutter/material.dart';

import '../api/domain/entities/player.dart';

class PlayerListTable extends StatelessWidget {
  final List<Player> players;

  const PlayerListTable({super.key, required this.players});

  @override
  Widget build(BuildContext context) {
    const double mobileBreakpoint = 600.0;
    final screenWidth = MediaQuery.of(context).size.width;

    if (players.isEmpty) {
      return const Center(
        child: Text(
          "Сервер пуст",
          style: TextStyle(fontSize: 18),
        ),
      );
    }

    if (screenWidth > mobileBreakpoint) {
      return Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              itemCount: players.length,
              itemBuilder: (context, index) {
                return _buildWidePlayerRow(players[index], context);
              },
            ),
          ),
        ],
      );
    } else {
      // Для узких экранов - просто список карточек без заголовка
      return ListView.builder(
        padding: const EdgeInsets.all(12.0),
        itemCount: players.length,
        itemBuilder: (context, index) {
          return _buildMobilePlayerCard(players[index], context);
        },
      );
    }
  }

  // МАКЕТ ДЛЯ ШИРОКИХ ЭКРАНОВ

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
          _buildCell(const Text('Звание'),
              flex: 5, alignment: Alignment.center),
          _buildCell(const Text('Киллы'), flex: 3, alignment: Alignment.center),
          _buildCell(const Text('K/D'), flex: 3, alignment: Alignment.center),
          _buildCell(const Text('HS%'), flex: 3, alignment: Alignment.center),
          _buildCell(const Text('Время'), flex: 4, alignment: Alignment.center),
          _buildCell(const Text('Пинг'),
              flex: 2, alignment: Alignment.centerRight),
        ],
      ),
    );
  }

  Widget _buildWidePlayerRow(Player player, BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final isTerrorist = player.team == "Terrorist";
    final startColor = isTerrorist ? Colors.orange : Colors.blue;
    final endColor = isDarkMode
        ? Colors.black.withValues(alpha: 0.4)
        : Colors.white.withValues(alpha: 0.4);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        gradient: LinearGradient(
          colors: [startColor.withValues(alpha: 0.6), endColor],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          stops: const [0.0, 0.7],
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
            Image.network(player.rankImageUrl,
                width: 60, height: 20, fit: BoxFit.contain),
            flex: 5,
            alignment: Alignment.center,
          ),
          _buildCell(Text(player.kills.toString()),
              flex: 3, alignment: Alignment.center),
          _buildCell(Text(player.kdRatio.toString()),
              flex: 3, alignment: Alignment.center),
          _buildCell(Text('${player.hsPercent}%'),
              flex: 3, alignment: Alignment.center),
          _buildCell(Text(player.timeInGame),
              flex: 4, alignment: Alignment.center),
          _buildCell(Text(player.ping.toString()),
              flex: 2, alignment: Alignment.centerRight),
        ],
      ),
    );
  }

  // МАКЕТ ДЛЯ УЗКИХ ЭКРАНОВ

  Widget _buildMobilePlayerCard(Player player, BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final isTerrorist = player.team == "Terrorist";
    final startColor = isTerrorist ? Colors.orange : Colors.blue;
    final endColor = isDarkMode
        ? Colors.black.withValues(alpha: 0.4)
        : Colors.white.withValues(alpha: 0.4);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        gradient: LinearGradient(
          colors: [startColor.withValues(alpha: 0.5), endColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Chip(
                  label: Text('LVL ${player.faceitLevel}'),
                  visualDensity: VisualDensity.compact,
                  padding: const EdgeInsets.all(0),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    player.playerName,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
            const Divider(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Звание:'),
                Image.network(player.rankImageUrl,
                    width: 80, height: 24, fit: BoxFit.contain),
              ],
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: [
                _buildStatChip('Киллы', player.kills.toString()),
                _buildStatChip('K/D', player.kdRatio.toString()),
                _buildStatChip('HS%', '${player.hsPercent}%'),
                _buildStatChip('Время', player.timeInGame),
                _buildStatChip('Пинг', player.ping.toString()),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildStatChip(String label, String value) {
    return Chip(
      label: Text('$label: $value'),
      visualDensity: VisualDensity.compact,
      padding: const EdgeInsets.symmetric(horizontal: 4),
    );
  }

  Widget _buildCell(Widget child,
      {required int flex, Alignment alignment = Alignment.centerLeft}) {
    return Expanded(
      flex: flex,
      child: Container(
        alignment: alignment,
        child: child,
      ),
    );
  }
}
