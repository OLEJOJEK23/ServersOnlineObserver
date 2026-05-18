import 'package:flutter/material.dart';
import 'package:servers_online_observer/widgets/settings_bottom_sheet.dart';

class NavigationRailProjects extends StatefulWidget {
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
  State<NavigationRailProjects> createState() => _NavigationRailProjectsState();
}

class _NavigationRailProjectsState extends State<NavigationRailProjects>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800), // время одного оборота
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

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
                  selectedIndex: widget.selectedIndex,
                  onDestinationSelected: widget.onDestinationSelected,
                  destinations: widget.projects.asMap().entries.map((e) {
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
              SizedBox(
                height: 4,
                width: 140,
                child: Divider(thickness: 2, color: colorScheme.outlineVariant),
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
                      icon: AnimatedBuilder(
                        animation: _animationController,
                        builder: (context, child) {
                          return Transform.rotate(
                            angle: _animationController.value,
                            child: child,
                          );
                        },
                        child: const Icon(Icons.settings_rounded),
                      ),
                      tooltip: "Настройки",
                      onPressed: () {
                        _animationController.forward(from: 0.0).then(
                          (_) {
                            _animationController.reset();
                          },
                        );
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) => const SettingsBottomSheet(),
                        );
                      },
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
