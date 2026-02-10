import 'package:flutter/material.dart';

const ColorScheme lightColorScheme = ColorScheme(
  brightness: Brightness.light,

  // Основной цвет и его вариации
  primary: Color(0xFF256EFF),
  onPrimary: Colors.white,
  primaryContainer: Color(0xFFDDE8FF),
  // очень светлый оттенок основного
  onPrimaryContainer: Color(0xFF001A5C),

  // Акцентный
  secondary: Color(0xFF3DDC97),
  onSecondary: Color(0xFF001F12),
  secondaryContainer: Color(0xFFDFF7EE),
  onSecondaryContainer: Color(0xFF002112),

  // Дополнительный
  tertiary: Color(0xFF46237A),
  onTertiary: Colors.white,
  tertiaryContainer: Color(0xFFE8DEFF),
  onTertiaryContainer: Color(0xFF1C0038),

  // Нейтральные поверхности — только на основе белого + очень лёгкий оттенок основного
  surface: Color(0xFFFAFCFF),
  onSurface: Color(0xFF0F1A3A),
  onSurfaceVariant: Color(0xFF3A4666),

  // Контуры и тени — на основе основного/дополнительного с прозрачностью
  outline: Color(0xFF6A88CC),
  // приглушённый основной
  outlineVariant: Color(0xFFB8C8FF),
  shadow: Color(0x1A256EFF),
  // основной с opacity ~10%
  scrim: Color(0x4D000000),

  // Ошибка — используем приглушённый красный (но близкий по насыщенности к палитре)
  error: Color(0xFFFF4D4F),
  onError: Colors.white,
  errorContainer: Color(0xFFFFE0E0),
  onErrorContainer: Color(0xFF5C0000),
);

const ColorScheme darkColorScheme = ColorScheme(
  brightness: Brightness.dark,

  // Основной — светлее для читаемости
  primary: Color(0xFF80AFFF),
  // осветлённый #256EFF
  onPrimary: Color(0xFF001A4D),
  primaryContainer: Color(0xFF004CFF),
  onPrimaryContainer: Color(0xFFDDE8FF),

  // Акцентный — чуть светлее
  secondary: Color(0xFF7AEFC0),
  onSecondary: Color(0xFF002112),
  secondaryContainer: Color(0xFF004D3A),
  onSecondaryContainer: Color(0xFFDFF7EE),

  // Дополнительный — светлее
  tertiary: Color(0xFFD0B3FF),
  onTertiary: Color(0xFF2E004E),
  tertiaryContainer: Color(0xFF3A1A6A),
  onTertiaryContainer: Color(0xFFE8DEFF),

  // Поверхности — тёмные с лёгким намёком на основной
  surface: Color(0xFF0A1329),
  onSurface: Color(0xFFDDE8FF),
  onSurfaceVariant: Color(0xFFB8C8FF),

  // Контуры
  outline: Color(0xFF6A88CC),
  outlineVariant: Color(0xFF3A4A7A),
  shadow: Color(0x80000000),
  scrim: Color(0x99000000),

  // Ошибка
  error: Color(0xFFFF9999),
  onError: Color(0xFF330000),
  errorContainer: Color(0xFF660000),
  onErrorContainer: Color(0xFFFFE0E0),
);

final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: lightColorScheme,
  scaffoldBackgroundColor: lightColorScheme.surface,
  appBarTheme: AppBarTheme(
    backgroundColor: lightColorScheme.surface,
    foregroundColor: lightColorScheme.onSurface,
    elevation: 0,
    scrolledUnderElevation: 0.8,
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
    backgroundColor: lightColorScheme.surfaceContainerLowest,
    indicatorColor: lightColorScheme.primary.withAlpha(50),
    indicatorShape: const StadiumBorder(),
    selectedIconTheme:
        IconThemeData(color: lightColorScheme.onPrimary, size: 28),
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
);

final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: darkColorScheme,
  scaffoldBackgroundColor: darkColorScheme.surface,
  appBarTheme: AppBarTheme(
    backgroundColor: darkColorScheme.surface,
    foregroundColor: darkColorScheme.onSurface,
    elevation: 0,
    scrolledUnderElevation: 1.5,
    shadowColor: darkColorScheme.shadow,
    titleTextStyle: TextStyle(
      fontSize: 23,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.4,
      color: darkColorScheme.onSurface,
    ),
  ),
  cardTheme: CardTheme(
    elevation: 2,
    shadowColor: darkColorScheme.shadow,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    color: darkColorScheme.surfaceContainerHighest,
    clipBehavior: Clip.antiAlias,
  ),
  navigationRailTheme: NavigationRailThemeData(
    backgroundColor: darkColorScheme.surfaceContainerLowest,
    indicatorColor: darkColorScheme.primary.withAlpha(70),
    indicatorShape: const StadiumBorder(),
    selectedIconTheme:
        IconThemeData(color: darkColorScheme.onPrimary, size: 28),
    unselectedIconTheme:
        IconThemeData(color: darkColorScheme.onSurfaceVariant, size: 26),
    selectedLabelTextStyle: TextStyle(
      color: darkColorScheme.primary,
      fontWeight: FontWeight.w700,
      fontSize: 14,
    ),
    unselectedLabelTextStyle: TextStyle(
      color: darkColorScheme.onSurfaceVariant,
      fontWeight: FontWeight.w500,
      fontSize: 13,
    ),
    useIndicator: true,
    labelType: NavigationRailLabelType.all,
    minExtendedWidth: 260,
    minWidth: 80,
  ),
);
