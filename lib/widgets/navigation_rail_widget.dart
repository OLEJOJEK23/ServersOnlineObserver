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
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: IntrinsicHeight(
                child: NavigationRail(
                  extended: true,
                  minWidth: 140.0,
                  minExtendedWidth: 140.0,
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
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
          Column(
            children: [
              const SizedBox(
                height: 4,
                width: 140,
                child: Divider(),
              ),
              Material(
                elevation: 4,
                color: colorScheme.surface,
                child: SafeArea(
                  top: false,
                  bottom: true,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: IconButton(
                      icon: const Icon(Icons.settings_rounded),
                      tooltip: "Настройки",
                      onPressed: () => print("settings"),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
