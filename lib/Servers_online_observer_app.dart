import 'package:flutter/material.dart';
import 'package:servers_online_observer/features/home_page.dart';

class ServersOnlineObserverApp extends StatelessWidget {
  const ServersOnlineObserverApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Servers online observer tray app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TrayHomePage(),
    );
  }
}
