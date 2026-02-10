import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servers_online_observer/features/home_page.dart';
import 'package:servers_online_observer/theme/theme.dart';

import 'blocks/theme/theme_cubit.dart';

class ServersOnlineObserverApp extends StatelessWidget {
  const ServersOnlineObserverApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return MaterialApp(
          title: 'Servers Online Observer',
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: state.isDark ? ThemeMode.dark : ThemeMode.light,
          home: const TrayHomePage(),
        );
      },
    );
  }
}
