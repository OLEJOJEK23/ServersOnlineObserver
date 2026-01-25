import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:servers_online_observer/api/core/network/api_client.dart';
import 'package:servers_online_observer/api/data/repositories/online_repository_impl.dart';
import 'package:servers_online_observer/api/domain/repositories/online_repository.dart';
import 'package:servers_online_observer/api/domain/usecases/get_online.dart';
import 'package:servers_online_observer/servers_online_observer_app.dart';
import 'package:window_manager/window_manager.dart';

import 'api/core/network/network_config.dart';
import 'api/data/sources/local/cache_manager.dart';
import 'api/data/sources/remote/api_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  WindowOptions windowOptions = const WindowOptions(
    size: Size(800, 500),
    minimumSize: Size(800, 500),
    center: true,
    backgroundColor: Colors.transparent,
    titleBarStyle: TitleBarStyle.normal,
    windowButtonVisibility: true,
  );
  windowManager.waitUntilReadyToShow(
    windowOptions,
    () async {
      //await windowManager.hide();
    },
  );

  GetIt.I.registerLazySingleton(() => ApiClient.backendInstance,
      instanceName: 'backendDio');

  GetIt.I.registerLazySingleton<ApiService>(
    () => ApiService(GetIt.I(instanceName: 'backendDio'),
        baseUrl: NetworkConfig.baseUrl),
    instanceName: 'backendDio',
  );
  GetIt.I.registerLazySingleton<CacheManager>(() => CacheManagerImpl());
  GetIt.I.registerLazySingleton<OnlineRepository>(
    () => OnlineRepositoryImpl(
      apiService: GetIt.I<ApiService>(instanceName: 'backendDio'),
      cacheManager: GetIt.I<CacheManager>(),
    ),
  );
  GetIt.I.registerLazySingleton(() => GetOnline(GetIt.I<OnlineRepository>()));
  runApp(const ServersOnlineObserverApp());
}
