import 'package:flutter/material.dart';

class NavigationRailProjects extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  final List<String> projects;

  const NavigationRailProjects({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.projects,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: NavigationRail(
        extended: true,
        minWidth: 140.0,
        minExtendedWidth: 140.0,
        // фиксированная ширина — нет подёргивания
        backgroundColor: colorScheme.surfaceContainerLowest,
        selectedIndex: selectedIndex,
        onDestinationSelected: onDestinationSelected,
        destinations: projects.asMap().entries.map((e) {
          final name = e.value;
          return NavigationRailDestination(
            icon: const Icon(Icons.dns_rounded, size: 28),
            selectedIcon: const Icon(Icons.dns_outlined, size: 28),
            label: Text(
              name,
              style: const TextStyle(fontSize: 15),
              overflow: TextOverflow.ellipsis, // на всякий случай
              maxLines: 1,
            ),
          );
        }).toList(),
      ),
    );
  }
}
