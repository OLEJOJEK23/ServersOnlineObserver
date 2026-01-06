//import 'package:shared_preferences/shared_preferences.dart';

abstract class CacheManager {
  Future<void> saveData(String key, dynamic data);

  Future<dynamic> getData(String key);

  Future<void> clearCache();
}

class CacheManagerImpl implements CacheManager {
  //final SharedPreferences sharedPreferences;

  //CacheManagerImpl(this.sharedPreferences);

  @override
  Future<void> saveData(String key, dynamic data) async {}

  @override
  Future<dynamic> getData(String key) async {}

  @override
  Future<void> clearCache() async {}
}
