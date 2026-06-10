import 'package:flutter/material.dart';

import '../../api/domain/entities/player.dart';

class WidePlayerRow extends StatelessWidget {
  final Player player;

  const WidePlayerRow({super.key, required this.player});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final isTerrorist = player.team == "Terrorist";

    final startColor = isTerrorist ? Colors.orange : Colors.blue;
    final endColor = isDarkMode
        ? Colors.black.withValues(
            alpha: 0.4,
          )
        : Colors.white.withValues(
            alpha: 0.4,
          );

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
