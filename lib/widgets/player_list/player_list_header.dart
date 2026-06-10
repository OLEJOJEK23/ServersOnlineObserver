import 'package:flutter/material.dart';

class PlayerListHeader extends StatelessWidget {
  const PlayerListHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = theme.textTheme.bodySmall?.copyWith(
      fontWeight: FontWeight.bold,
      color: theme.colorScheme.onSurfaceVariant,
    );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
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
          _buildCell(Text('LVL', style: textStyle), flex: 2),
          _buildCell(Text('Игрок', style: textStyle), flex: 6),
          _buildCell(
            Text('Звание', style: textStyle),
            flex: 5,
            alignment: Alignment.center,
          ),
          _buildCell(
            Text('Киллы', style: textStyle),
            flex: 3,
            alignment: Alignment.center,
          ),
          _buildCell(
            Text('K/D', style: textStyle),
            flex: 3,
            alignment: Alignment.center,
          ),
          _buildCell(
            Text('HS%', style: textStyle),
            flex: 3,
            alignment: Alignment.center,
          ),
          _buildCell(
            Text('Время', style: textStyle),
            flex: 4,
            alignment: Alignment.center,
          ),
          _buildCell(
            Text('Пинг', style: textStyle),
            flex: 2,
            alignment: Alignment.centerRight,
          ),
        ],
      ),
    );
  }

  Widget _buildCell(
    Widget child, {
    required int flex,
    Alignment alignment = Alignment.centerLeft,
  }) {
    return Expanded(
      flex: flex,
      child: Container(
        alignment: alignment,
        child: child,
      ),
    );
  }
}
