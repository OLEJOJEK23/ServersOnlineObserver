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

  @override
  void initState() {
    trayManager.addListener(this);
    windowManager.addListener(this);
    _fetchOnline();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Servers online observer"),
      ),
      body: Center(
        child: Text("Текущий онлайн: ${_online!.online}"),
      ),
    );
  }
}
