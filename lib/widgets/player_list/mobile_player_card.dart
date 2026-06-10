import 'package:flutter/material.dart';

import '../../api/domain/entities/player.dart';

class MobilePlayerCard extends StatelessWidget {
  final Player player;

  const MobilePlayerCard({super.key, required this.player});

  @override
  Widget build(BuildContext context) {
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
                  labelStyle:
                      TextStyle(color: theme.colorScheme.onSecondaryContainer),
                  backgroundColor: theme.colorScheme.secondaryContainer,
                  visualDensity: VisualDensity.compact,
                  padding: const EdgeInsets.all(0),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    player.playerName,
                    style: theme.textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
            Divider(
              height: 16,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.1),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Звание:', style: theme.textTheme.bodyMedium),
                Image.network(
                  player.rankImageUrl,
                  width: 80,
                  height: 24,
                  fit: BoxFit.contain,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: [
                _buildStatChip('Киллы', player.kills.toString(), theme),
                _buildStatChip('K/D', player.kdRatio.toString(), theme),
                _buildStatChip('HS%', '${player.hsPercent}%', theme),
                _buildStatChip('Время', player.timeInGame, theme),
                _buildStatChip('Пинг', player.ping.toString(), theme),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildStatChip(String label, String value, ThemeData theme) {
    return Chip(
      label: Text('$label: $value'),
      labelStyle: TextStyle(color: theme.colorScheme.onSurfaceVariant),
      backgroundColor: theme.colorScheme.surfaceContainerHighest,
      visualDensity: VisualDensity.compact,
      padding: const EdgeInsets.symmetric(horizontal: 4),
    );
  }
}
