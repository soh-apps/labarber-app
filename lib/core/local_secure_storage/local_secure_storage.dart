import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalSecureStorage {
  FlutterSecureStorage get _storage => const FlutterSecureStorage();

  Future<void> clear() async {
    await _storage.deleteAll();
  }

  Future<bool> contains(String key) async {
    return _storage.containsKey(key: key);
  }

  Future<String?> read(String key) async {
    return _storage.read(key: key);
  }

  Future<void> remove(String key) async {
    return _storage.delete(key: key);
  }

  Future<void> write({required String key, required String value}) async {
    await _storage.write(key: key, value: value);
  }
}
