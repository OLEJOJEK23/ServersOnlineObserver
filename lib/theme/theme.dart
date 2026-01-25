import 'package:flutter/material.dart';

final ColorScheme lightColorScheme = ColorScheme.fromSeed(
  seedColor: const Color(0xFF006D77),
  // основной акцент — teal/cyan
  brightness: Brightness.light,
  primary: const Color(0xFF006D77),
  onPrimary: Colors.white,
  primaryContainer: const Color(0xFF9BE8E0),
  onPrimaryContainer: const Color(0xFF00332E),
  secondary: const Color(0xFF83C5BE),
  onSecondary: Colors.black87,
  secondaryContainer: const Color(0xFFE0F2F1),
  surface: const Color(0xFFFAFDFC),
  onSurface: Colors.black87,
  onSurfaceVariant: Colors.black54,
  error: const Color(0xFFBA1A1A),
  outline: const Color(0xFF6B7680),
  shadow: Colors.black.withValues(alpha: 0.08),
);

final ColorScheme darkColorScheme = ColorScheme.fromSeed(
  seedColor: const Color(0xFF83C5BE),
  brightness: Brightness.dark,
  primary: const Color(0xFF83C5BE),
  onPrimary: Colors.black87,
  primaryContainer: const Color(0xFF006D77),
  onPrimaryContainer: Colors.white,
  secondary: const Color(0xFF006D77),
  onSecondary: Colors.white,
  secondaryContainer: const Color(0xFF004D52),
  surface: const Color(0xFF0D1F1E),
  onSurface: Colors.white70,
  onSurfaceVariant: Colors.white60,
  error: const Color(0xFFFFB4AB),
  outline: const Color(0xFF8A9AA6),
  shadow: Colors.black.withValues(alpha: 0.4),
);

final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: lightColorScheme,
  scaffoldBackgroundColor: lightColorScheme.surface,
  appBarTheme: AppBarTheme(
    backgroundColor: lightColorScheme.surface,
    foregroundColor: lightColorScheme.onSurface,
    elevation: 0,
    scrolledUnderElevation: 1,
    shadowColor: lightColorScheme.shadow,
    centerTitle: false,
    titleTextStyle: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.3,
      color: lightColorScheme.onSurface,
    ),
  ),
  cardTheme: CardTheme(
    elevation: 1,
    shadowColor: lightColorScheme.shadow,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    color: lightColorScheme.surfaceContainerLowest,
    margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 0),
  ),
  listTileTheme: ListTileThemeData(
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    selectedColor: lightColorScheme.primary,
    selectedTileColor: lightColorScheme.primaryContainer.withOpacity(0.24),
  ),
  navigationRailTheme: NavigationRailThemeData(
    backgroundColor: lightColorScheme.surfaceContainer,
    indicatorColor: lightColorScheme.primaryContainer,
    selectedIconTheme:
        IconThemeData(color: lightColorScheme.onPrimaryContainer),
    unselectedIconTheme:
        IconThemeData(color: lightColorScheme.onSurfaceVariant),
    selectedLabelTextStyle: TextStyle(
      color: lightColorScheme.onPrimaryContainer,
      fontWeight: FontWeight.w600,
    ),
    unselectedLabelTextStyle:
        TextStyle(color: lightColorScheme.onSurfaceVariant),
    useIndicator: true,
    labelType: NavigationRailLabelType.all,
    minExtendedWidth: 240,
    minWidth: 72,
  ),
  dividerTheme: DividerThemeData(
    color: lightColorScheme.outlineVariant,
    thickness: 1,
  ),
  iconTheme: IconThemeData(color: lightColorScheme.onSurfaceVariant),
  textTheme: ThemeData.light().textTheme.apply(
        bodyColor: lightColorScheme.onSurface,
        displayColor: lightColorScheme.onSurface,
      ),
);

final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: darkColorScheme,
  scaffoldBackgroundColor: darkColorScheme.surface,
  appBarTheme: AppBarTheme(
    backgroundColor: darkColorScheme.surface,
    foregroundColor: darkColorScheme.onSurface,
    elevation: 0,
    scrolledUnderElevation: 2,
    shadowColor: darkColorScheme.shadow,
    centerTitle: false,
    titleTextStyle: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.3,
      color: darkColorScheme.onSurface,
    ),
  ),
  cardTheme: CardTheme(
    elevation: 2,
    shadowColor: darkColorScheme.shadow,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    color: darkColorScheme.surfaceContainerLowest,
    margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 0),
  ),
  listTileTheme: ListTileThemeData(
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    selectedColor: darkColorScheme.primary,
    selectedTileColor: darkColorScheme.primaryContainer.withOpacity(0.20),
  ),
  navigationRailTheme: NavigationRailThemeData(
    backgroundColor: darkColorScheme.surfaceContainer,
    indicatorColor: darkColorScheme.primaryContainer.withOpacity(0.3),
    selectedIconTheme: IconThemeData(color: darkColorScheme.onPrimaryContainer),
    unselectedIconTheme: IconThemeData(color: darkColorScheme.onSurfaceVariant),
    selectedLabelTextStyle: TextStyle(
      color: darkColorScheme.onPrimaryContainer,
      fontWeight: FontWeight.w600,
    ),
    unselectedLabelTextStyle:
        TextStyle(color: darkColorScheme.onSurfaceVariant),
    useIndicator: true,
    labelType: NavigationRailLabelType.all,
    minExtendedWidth: 240,
    minWidth: 72,
  ),
  dividerTheme: DividerThemeData(
    color: darkColorScheme.outlineVariant,
    thickness: 1,
  ),
  iconTheme: IconThemeData(color: darkColorScheme.onSurfaceVariant),
  textTheme: ThemeData.dark().textTheme.apply(
        bodyColor: darkColorScheme.onSurface,
        displayColor: darkColorScheme.onSurface,
      ),
);
