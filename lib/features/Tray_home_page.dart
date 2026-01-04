import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tray_manager/tray_manager.dart';
import 'package:window_manager/window_manager.dart';

class TrayHomePage extends StatefulWidget {
  const TrayHomePage({super.key});

  @override
  State<TrayHomePage> createState() => _TrayHomePageState();
}

class _TrayHomePageState extends State<TrayHomePage>
    with TrayListener, WindowListener {
  Timer? _timer;
  int _online = 0;

  @override
  void initState() {
    trayManager.addListener(this);
    windowManager.addListener(this);
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
    await trayManager.setIcon("assets/icons/ico.ico");
    await trayManager.setToolTip('Онлайн: $_online');
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
    print('Tray icon configured');
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Servers online observer"),
      ),
      body: Center(
        child: Text("Текущий онлайн: $_online"),
      ),
    );
  }
}
