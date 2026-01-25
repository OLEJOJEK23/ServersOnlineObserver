import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:servers_online_observer/api/domain/entities/online.dart';
import 'package:tray_manager/tray_manager.dart';
import 'package:window_manager/window_manager.dart';

import '../api/domain/usecases/get_online.dart';

class TrayHomePage extends StatefulWidget {
  const TrayHomePage({super.key});

  @override
  State<TrayHomePage> createState() => _TrayHomePageState();
}

class _TrayHomePageState extends State<TrayHomePage>
    with TrayListener, WindowListener {
  final GetOnline _getOnline = GetIt.I<GetOnline>();
  Timer? _timer;
  Online? _online;
  bool _isOnlineLoading = false;
  String? _onlineError;
  int _selectedIndex = 0;

  @override
  void initState() {
    trayManager.addListener(this);
    windowManager.addListener(this);
    //_fetchOnline();
    _initTray();
    windowManager.setPreventClose(true);
    super.initState();
  }

  @override
  void dispose() {
    trayManager.removeListener(this);
    windowManager.removeListener(this);
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _initTray() async {
    await trayManager.setIcon("assets/icons/logo.ico");
    await trayManager.setToolTip('Онлайн: ${_online!.online}');
    Menu menu = Menu(
      items: [
        MenuItem(
          key: "show_window",
          label: "Показать окно",
          onClick: (_) => windowManager.show(),
        ),
        MenuItem(
          key: "update_online",
          label: "Обновить онлайн",
          onClick: (_) => print("!"),
        ),
        MenuItem(
          key: "exit_app",
          label: "Выход",
          onClick: (_) => exit(0),
        ),
      ],
    );
    await trayManager.setContextMenu(menu);
  }

  Future<void> _fetchOnline() async {
    setState(() {
      _isOnlineLoading = true;
      _onlineError = null;
    });
    final result = await _getOnline();
    result.fold(
      (failure) => setState(() {
        _onlineError = failure.message;
        _isOnlineLoading = true;
      }),
      (online) => setState(() {
        _online = online[0];
        _isOnlineLoading = false;
      }),
    );
    if (_onlineError != null) {
      print(_onlineError);
    }
  }

  @override
  void onTrayIconMouseDown() {
    windowManager.show();
  }

  @override
  void onTrayIconRightMouseDown() {
    trayManager.popUpContextMenu();
  }

  @override
  void onWindowClose() {
    windowManager.hide();
  }

  void settings() {
    print("settings");
  }

  void refresh() {
    print("refresh");
  }

  void add() {
    print("add");
  }

  void change_theme() {
    print("change_theme");
  }

  final List<Map<String, String>> _currentServers = [
    {"name": "⚡ #1 ДЕТИ МИРАЖА", "map": "de_mirage", "online": "12/32"},
    {"name": "⚡ #2 ДЕТИ АНТИЧНОСТИ", "map": "de_anubis", "online": "0/24"},
    {"name": "ONLY MIRAGE | NOCHEATS", "map": "de_mirage", "online": "45/64"},
    {"name": "CLASSIC | 128 TICK", "map": "de_dust2", "online": "8/32"},
    {"name": "AIM MAPS | FFA", "map": "aim_map", "online": "3/20"},
    {"name": "RETURNS #3", "map": "de_inferno", "online": "19/40"},
    {"name": "MIRAGE ONLY 5v5", "map": "de_mirage", "online": "7/10"},
  ];

  final List<String> _projects = [
    "METACS.RU",
    "PlayCS.ru",
    "OnlyMirage",
    "DeathMatch Only",
    "Zombie Escape",
    "Classic 128 Tick",
    "Aim Training",
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Servers Online Observer"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_rounded),
            tooltip: "Добавить проект",
            onPressed: () => print("add project"),
          ),
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            tooltip: "Обновить данные",
            onPressed: () => print("refresh"),
          ),
          IconButton(
            icon: Icon(Icons.dark_mode_rounded),
            tooltip: "Сменить тему",
            onPressed: () => print("toggle theme"),
          ),
          IconButton(
            icon: const Icon(Icons.settings_rounded),
            tooltip: "Настройки",
            onPressed: () => print("settings"),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Row(
        children: [
          NavigationRail(
            extended: true,
            selectedIndex: _selectedIndex,
            onDestinationSelected: (index) {
              setState(() => _selectedIndex = index);
            },
            destinations: _projects.asMap().entries.map((e) {
              final i = e.key;
              final name = e.value;
              return NavigationRailDestination(
                icon: Icon(Icons.dns_rounded, size: 28),
                selectedIcon: Icon(Icons.dns_rounded, size: 28),
                label: Text(name, style: const TextStyle(fontSize: 15)),
              );
            }).toList(),
          ),
          VerticalDivider(
            width: 1,
            thickness: 1,
            color: colorScheme.outlineVariant,
          ),
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  sliver: SliverToBoxAdapter(
                    child: Text(
                      "${_projects[_selectedIndex]} — Серверы",
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.2,
                      ),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final server = _currentServers[index];
                        final onlineParts = server["online"]!.split('/');
                        final current = int.tryParse(onlineParts[0]) ?? 0;
                        final max = int.tryParse(onlineParts[1]) ?? 0;
                        final isActive = current > 0;

                        return Card(
                          child: InkWell(
                            borderRadius: BorderRadius.circular(16),
                            onTap: () =>
                                print("Открыть детали: ${server["name"]}"),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 28,
                                    backgroundColor: isActive
                                        ? colorScheme.primary
                                            .withValues(alpha: 0.12)
                                        : colorScheme.secondary,
                                    child: Icon(
                                      Icons.public_rounded,
                                      color: isActive
                                          ? colorScheme.primary
                                          : colorScheme.onSurfaceVariant,
                                      size: 32,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          server["name"]!,
                                          style: theme.textTheme.titleMedium
                                              ?.copyWith(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          "Карта: ${server["map"]}",
                                          style: theme.textTheme.bodyMedium
                                              ?.copyWith(
                                            color: colorScheme.onSurfaceVariant,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "$current / $max",
                                        style: theme.textTheme.titleLarge
                                            ?.copyWith(
                                          fontWeight: FontWeight.w700,
                                          color: isActive
                                              ? colorScheme.primary
                                              : colorScheme.onSurfaceVariant,
                                        ),
                                      ),
                                      Text(
                                        "игроков",
                                        style:
                                            theme.textTheme.bodySmall?.copyWith(
                                          color: colorScheme.onSurfaceVariant,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      childCount: _currentServers.length,
                    ),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 24)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Card serverCard(int current, Map<String, String> server, int max) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: current > 0 ? Colors.green : Colors.grey,
          child: const Icon(Icons.people, color: Colors.white),
        ),
        title: Text(
          server["ServerName"]!,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text("Карта: ${server["ServerCurrentMap"]}"),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "$current/$max",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: current > 0 ? Colors.green : Colors.grey,
              ),
            ),
            const Text(
              "игроков",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
