import 'package:flutter/material.dart';

class SettingsBottomSheet extends StatefulWidget {
  const SettingsBottomSheet({super.key});

  @override
  State<SettingsBottomSheet> createState() => _SettingsBottomSheetState();
}

class _SettingsBottomSheetState extends State<SettingsBottomSheet> {
  bool _notificationsEnabled = true;
  bool _autoUpdateEnabled = true;
  String _updateInterval = '30 секунд';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Заголовок
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 16, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Настройки',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close_rounded),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),

            const Divider(height: 1),

            Flexible(
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(vertical: 8),
                children: [
                  // Переключатель уведомлений
                  SwitchListTile(
                    title: const Text('Уведомления об онлайне'),
                    subtitle: const Text(
                        'Получать push-уведомления при изменении онлайна'),
                    value: _notificationsEnabled,
                    activeColor: colorScheme.primary,
                    onChanged: (value) {
                      setState(() => _notificationsEnabled = value);
                    },
                  ),

                  const Divider(indent: 16, endIndent: 16),

                  // Автообновление данных
                  SwitchListTile(
                    title: const Text('Автоматическое обновление'),
                    subtitle:
                        const Text('Обновлять данные серверов автоматически'),
                    value: _autoUpdateEnabled,
                    activeColor: colorScheme.primary,
                    onChanged: (value) {
                      setState(() => _autoUpdateEnabled = value);
                    },
                  ),

                  if (_autoUpdateEnabled) ...[
                    ListTile(
                      leading: const Icon(Icons.timer_outlined),
                      title: const Text('Интервал обновления'),
                      trailing: DropdownButton<String>(
                        value: _updateInterval,
                        items: const [
                          DropdownMenuItem(
                            value: '15 секунд',
                            child: Text('15 секунд'),
                          ),
                          DropdownMenuItem(
                            value: '30 секунд',
                            child: Text('30 секунд'),
                          ),
                          DropdownMenuItem(
                            value: '1 минута',
                            child: Text('1 минута'),
                          ),
                          DropdownMenuItem(
                            value: '5 минут',
                            child: Text('5 минут'),
                          ),
                        ],
                        onChanged: (value) {
                          if (value != null) {
                            setState(() => _updateInterval = value);
                          }
                        },
                      ),
                    ),
                    const Divider(indent: 16, endIndent: 16),
                  ],

                  ListTile(
                    leading: const Icon(Icons.info_outline_rounded),
                    title: const Text('О приложении'),
                    subtitle: const Text('Версия 1.0.0 • © 2026'),
                    onTap: () {
                      // можно открыть диалог с информацией
                      showAboutDialog(
                        context: context,
                        applicationName: 'Servers Online Observer',
                        applicationVersion: '1.0.0',
                        children: [
                          const Text(
                            'Приложение для мониторинга онлайна серверов CS:GO/CS2',
                          ),
                        ],
                      );
                    },
                  ),

                  const Divider(indent: 16, endIndent: 16),

                  ListTile(
                    leading: const Icon(Icons.restore_rounded,
                        color: Colors.redAccent),
                    title: const Text(
                      'Сбросить настройки',
                      style: TextStyle(color: Colors.redAccent),
                    ),
                    onTap: () {
                      // диалог подтверждения
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Сбросить настройки?'),
                          content: const Text(
                            'Все настройки будут возвращены к значениям по умолчанию.',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Отмена'),
                            ),
                            TextButton(
                              onPressed: () {
                                // логика сброса
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              child: const Text(
                                'Сбросить',
                                style: TextStyle(color: Colors.redAccent),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            // Нижняя кнопка закрытия (опционально)
            Padding(
              padding: const EdgeInsets.all(16),
              child: FilledButton(
                onPressed: () => Navigator.pop(context),
                style: FilledButton.styleFrom(
                  minimumSize: const Size(double.infinity, 52),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                ),
                child: const Text('Готово'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
