import 'package:flutter/material.dart';
import 'package:servers_online_observer/features/home_page.dart';
import 'package:servers_online_observer/theme/theme.dart';

class ServersOnlineObserverApp extends StatelessWidget {
  const ServersOnlineObserverApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Servers online observer tray app',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      home: const TrayHomePage(),
    );
  }
}
