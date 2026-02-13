import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:servers_online_observer/api/domain/entities/online.dart';
import 'package:servers_online_observer/widgets/navigation_rail_widget.dart';
import 'package:servers_online_observer/widgets/server_bottom_sheet.dart';
import 'package:servers_online_observer/widgets/server_card_widget.dart';
import 'package:tray_manager/tray_manager.dart';
import 'package:window_manager/window_manager.dart';

import '../api/domain/usecases/get_online.dart';
import '../blocks/theme/theme_cubit.dart';

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
  void initState() {
    if (Platform.isWindows) {
      trayManager.addListener(this);
      windowManager.addListener(this);
      _initTray();
      //windowManager.setPreventClose(true);
    }
    //_fetchOnline();
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
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true, // важно для клавиатуры
                backgroundColor: Colors.transparent,
                builder: (context) => NewServerBottomSheet(
                  onAdd: (name, url) {},
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            tooltip: "Обновить данные",
            onPressed: () => print("refresh"),
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return ScaleTransition(scale: animation, child: child);
            },
            child: IconButton(
              key: ValueKey<bool>(context.watch<ThemeCubit>().state.isDark),
              icon: Icon(
                context.watch<ThemeCubit>().state.isDark
                    ? Icons.light_mode_rounded
                    : Icons.dark_mode_rounded,
                size: 24,
              ),
              tooltip: context.watch<ThemeCubit>().state.isDark
                  ? 'Переключить на светлую тему'
                  : 'Переключить на тёмную тему',
              onPressed: () {
                context.read<ThemeCubit>().toggleTheme();
              },
            ),
          ),
          const SizedBox(width: 10),
        ],
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(4.0),
          child: Divider(
            thickness: 2,
          ),
        ),
      ),
      body: Row(
        children: [
          NavigationRailProjects(
              selectedIndex: _selectedIndex,
              onDestinationSelected: (index) {
                setState(() => _selectedIndex = index);
              },
              projects: _projects),
          VerticalDivider(
            width: 2,
            thickness: 2,
            color: colorScheme.outlineVariant,
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              itemCount: _currentServers.length,
              itemBuilder: (context, index) {
                final server = _currentServers[index];
                return ServerCard(
                  server: server,
                  theme: theme,
                  colorScheme: colorScheme,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
