import 'package:flutter/material.dart';
import 'package:servers_online_observer/widgets/players_bottom_sheet.dart';

class ServerCard extends StatelessWidget {
  final Map<String, String> server;
  final ThemeData theme;
  final ColorScheme colorScheme;

  const ServerCard({
    super.key,
    required this.server,
    required this.theme,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    final parts = server["online"]!.split('/');
    final curr = int.tryParse(parts[0]) ?? 0;
    final maxx = int.tryParse(parts[1]) ?? 0;
    final active = curr > 0;

    final primaryLight = Color.fromRGBO(13, 148, 136, active ? 0.15 : 0.08);

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOutCubic,
      builder: (ctx, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - value)),
            child: child,
          ),
        );
      },
      child: Card(
        elevation: 5,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (context) => ServerPlayersBottomSheet(
                serverName: "⚡ METACS.RU ⚡ #1 ДЕТИ МИРАЖА",
                map: "de_mirage",
                currentPlayers: "5",
                maxPlayers: "32",
                scoreT: "1",
                scoreCT: "5",
                players: [
                  Player(
                    name: "eger_mEst1r",
                    rank: "Global Elite",
                    kills: 12,
                    deaths: 4,
                    hs: 67,
                    timeInGame: "00:07:08",
                    ping: 45,
                  ),
                  Player(
                    name: "lenroma5",
                    rank: "Silver I",
                    kills: 3,
                    deaths: 8,
                    hs: 33,
                    timeInGame: "00:05:09",
                    ping: 67,
                  ),
                  // Добавляй остальных игроков здесь
                ],
              ),
            );
          },
          hoverColor: const Color.fromRGBO(13, 148, 136, 0.08),
          splashColor: const Color.fromRGBO(13, 148, 136, 0.16),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: primaryLight,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    Icons.public_rounded,
                    color: active
                        ? colorScheme.primary
                        : colorScheme.onSurfaceVariant,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        server["name"]!,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(
                            Icons.map_outlined,
                            size: 16,
                            color: colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            server["map"]!,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "$curr / $maxx",
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: active
                            ? colorScheme.primary
                            : colorScheme.onSurfaceVariant.withAlpha(179),
                        letterSpacing: -0.8,
                      ),
                    ),
                    Text(
                      "игроков",
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant.withAlpha(191),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  children: [
                    IconButton(
                      onPressed: () => print("copy"),
                      icon: const Icon(Icons.copy),
                    ),
                    IconButton(
                      onPressed: () => print("connect"),
                      icon: const Icon(Icons.play_arrow),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
