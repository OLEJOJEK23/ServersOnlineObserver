import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:servers_online_observer/api/domain/usecases/get_servers.dart';
import 'package:servers_online_observer/widgets/navigation_rail_widget.dart';
import 'package:servers_online_observer/widgets/server_bottom_sheet.dart';
import 'package:servers_online_observer/widgets/server_card_widget.dart';
import 'package:tray_manager/tray_manager.dart';
import 'package:window_manager/window_manager.dart';

import '../api/domain/entities/server.dart';
import '../blocks/theme/theme_cubit.dart';

class TrayHomePage extends StatefulWidget {
  const TrayHomePage({super.key});

  @override
  State<TrayHomePage> createState() => _TrayHomePageState();
}

class _TrayHomePageState extends State<TrayHomePage>
    with TrayListener, WindowListener {
  final GetServers _getServers = GetIt.I<GetServers>();
  Timer? _timer;
  List<Server> _servers = [];
  bool _isLoading = false;
  String? _error;
  int _selectedIndex = 0;

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
    _fetchServers();
    _timer = Timer.periodic(const Duration(seconds: 30), (timer) {
      _fetchServers();
    });
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
    await trayManager.setToolTip('Servers Online Observer');
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
          onClick: (_) => _fetchServers(),
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

  Future<void> _fetchServers() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    final result = await _getServers();
    result.fold(
      (failure) => setState(() {
        _error = failure.message;
        _isLoading = false;
      }),
      (servers) => setState(() {
        _servers = servers;
        _isLoading = false;
      }),
    );
    if (_error != null) {
      print(_error);
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
    _fetchServers();
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
            onPressed: refresh,
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
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _error != null
                    ? Center(child: Text('Error: $_error'))
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        itemCount: _servers.length,
                        itemBuilder: (context, index) {
                          final server = _servers[index];
                          return ServerCard(
                            server: {
                              "name": server.serverName,
                              "map": server.serverCurrentMap,
                              "online": server.serverCurrentOnline,
                            },
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
