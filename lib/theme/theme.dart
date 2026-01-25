import 'package:flutter/material.dart';

final ColorScheme lightColorScheme = ColorScheme.fromSeed(
  seedColor: const Color(0xFFCC1A5E),
  brightness: Brightness.light,
  primary: const Color(0xFFDD3153),
  onPrimary: Colors.white,
  primaryContainer: const Color(0xFFB2DFDB),
  onPrimaryContainer: const Color(0xFF004D40),
  secondary: const Color(0xFF26A69A),
  secondaryContainer: const Color(0xFFE0F2F1),
  surface: const Color(0xFFFAFEFD),
  surfaceContainerHighest: const Color(0xFFEEF8F7),
  onSurface: const Color(0xFF0F2A2A),
  onSurfaceVariant: const Color(0xFF4A6362),
  outline: const Color(0xFF7A938F),
  outlineVariant: const Color(0xFFD3E5E3),
  shadow: const Color(0x14000000),
  // #000000 с opacity 0.08
  scrim: const Color(0x52000000), // #000000 с opacity 0.32
);

final ColorScheme darkColorScheme = ColorScheme.fromSeed(
  seedColor: const Color(0xFF4DB6AC),
  brightness: Brightness.dark,
  primary: const Color(0xFF4DB6AC),
  onPrimary: const Color(0xFF00201E),
  primaryContainer: const Color(0xFF00695C),
  secondary: const Color(0xFF80CBC4),
  surface: const Color(0xFF0A1F1E),
  surfaceContainerHighest: const Color(0xFF132F2D),
  onSurface: const Color(0xEBFFFFFF),
  // white с ~0.92
  onSurfaceVariant: const Color(0xB3FFFFFF),
  // white с ~0.70
  outline: const Color(0x6680CBC4),
  // с ~0.4
  shadow: const Color(0x80000000),
);

final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: lightColorScheme,
  scaffoldBackgroundColor: lightColorScheme.surface,
  appBarTheme: AppBarTheme(
    backgroundColor: lightColorScheme.surface,
    foregroundColor: lightColorScheme.onSurface,
    elevation: 0,
    scrolledUnderElevation: 0.5,
    shadowColor: lightColorScheme.shadow,
    titleTextStyle: TextStyle(
      fontSize: 23,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.4,
      color: lightColorScheme.onSurface,
    ),
  ),
  cardTheme: CardTheme(
    elevation: 1,
    shadowColor: lightColorScheme.shadow,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    color: lightColorScheme.surfaceContainerHighest,
    clipBehavior: Clip.antiAlias,
  ),
  navigationRailTheme: NavigationRailThemeData(
    backgroundColor: lightColorScheme.surface,
    indicatorColor: Color.fromRGBO(13, 148, 136, 0.18),
    // primary с opacity 0.18
    indicatorShape: const StadiumBorder(),
    selectedIconTheme: IconThemeData(color: lightColorScheme.primary, size: 28),
    unselectedIconTheme:
        IconThemeData(color: lightColorScheme.onSurfaceVariant, size: 26),
    selectedLabelTextStyle: TextStyle(
      color: lightColorScheme.primary,
      fontWeight: FontWeight.w700,
      fontSize: 14,
    ),
    unselectedLabelTextStyle: TextStyle(
      color: lightColorScheme.onSurfaceVariant,
      fontWeight: FontWeight.w500,
      fontSize: 13,
    ),
    useIndicator: true,
    labelType: NavigationRailLabelType.all,
    minExtendedWidth: 260,
    minWidth: 80,
  ),
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: {
      TargetPlatform.windows: ZoomPageTransitionsBuilder(),
      TargetPlatform.linux: ZoomPageTransitionsBuilder(),
      TargetPlatform.macOS: ZoomPageTransitionsBuilder(),
    },
  ),
);

// darkTheme аналогично, но с darkColorScheme
final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: darkColorScheme,
  scaffoldBackgroundColor: darkColorScheme.surface,
  // ... остальные свойства копируются по аналогии с lightTheme
);
