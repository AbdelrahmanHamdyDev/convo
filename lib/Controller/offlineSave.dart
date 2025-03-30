import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class OfflineStorage {
  Future<void> saveJson(String key, Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(data);
    print(
      "save:=============================$jsonString=================================",
    );
    await prefs.setString(key, jsonString);
  }

  Future<Map<String, dynamic>?> loadJson(String key) async {
    final prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString(key);

    if (jsonString != null && jsonString.isNotEmpty) {
      print(
        "load:=============================$jsonString=================================",
      );
      return jsonDecode(jsonString);
    } else {
      return null;
    }
  }

  Future<void> removeJson(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }
}
