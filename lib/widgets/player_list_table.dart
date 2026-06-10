import 'package:flutter/material.dart';
import 'package:servers_online_observer/widgets/player_list/mobile_player_card.dart';
import 'package:servers_online_observer/widgets/player_list/player_list_header.dart';
import 'package:servers_online_observer/widgets/player_list/wide_player_row.dart';
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
      // Десктопный макет
      return Column(
        children: [
          const PlayerListHeader(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              itemCount: players.length,
              itemBuilder: (context, index) {
                return WidePlayerRow(player: players[index]);
              },
            ),
          ),
        ],
      );
    } else {
      // Мобильный макет
      return ListView.builder(
        padding: const EdgeInsets.all(12.0),
        itemCount: players.length,
        itemBuilder: (context, index) {
          return MobilePlayerCard(player: players[index]);
        },
      );
    }
  }
}
