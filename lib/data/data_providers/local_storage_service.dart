import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  //Data:
  static late LocalStorageService instance;
  static late SharedPreferences _preferences;

  //Keys:
  static const String currentUid = 'current_uid',
      isLoggedInKey = 'is_logged_in_key';

  //Utils:
  static Future<LocalStorageService> getInstance() async {
    instance = LocalStorageService();
    _preferences = await SharedPreferences.getInstance();
    return instance;
  }

  dynamic _getFromDisk(String key) {
    final value = _preferences.get(key);
    return value;
  }

  void _saveToDisk<T>(String key, T content) {
    if (content is String) {
      _preferences.setString(key, content);
    } else if (content is bool) {
      _preferences.setBool(key, content);
    } else if (content is int) {
      _preferences.setInt(key, content);
    } else if (content is double) {
      _preferences.setDouble(key, content);
    } else if (content is List<String>) {
      _preferences.setStringList(key, content);
    }
  }

  //Getters:
  String get uid {
    if (_getFromDisk(currentUid) != null) {
      return _getFromDisk(currentUid).toString();
    } else {
      return '';
    }
  }

  bool get isLoggedIn {
    return _getFromDisk(isLoggedInKey) ?? false;
  }

  //Setters:
  set uid(String id) {
    _saveToDisk(currentUid, id);
  }

  set isLoggedIn(bool isLoggedIn) {
    _saveToDisk(isLoggedInKey, isLoggedIn);
  }
}
