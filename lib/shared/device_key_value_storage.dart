import 'package:library_app/core.dart';
import 'package:library_app/shared.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeviceKeyValueStorage implements KeyValueStorage {
  DeviceKeyValueStorage._(this._preferences, this._jsonStringConverter);

  final SharedPreferences _preferences;
  final JsonStringConverter _jsonStringConverter;

  static Future<DeviceKeyValueStorage> create({
    required JsonStringConverter jsonStringConverter,
  }) async {
    final sharedPreferences = await SharedPreferences.getInstance();

    return DeviceKeyValueStorage._(sharedPreferences, jsonStringConverter);
  }

  @override
  Future<Set<String>> getKeys() async {
    return _preferences.getKeys();
  }

  @override
  Future<T?> read<T>(String key) async {
    final value = _preferences.getString(key);

    if (value == null) {
      return null;
    }

    return _jsonStringConverter.fromJsonString<T>(value);
  }

  @override
  Future<void> remove(String key) async {
    await _preferences.remove(key);
  }

  @override
  Future<void> write<T>(String key, T value) async {
    final stringValue = _jsonStringConverter.toJsonString(value);

    await _preferences.setString(key, stringValue);
  }
}
