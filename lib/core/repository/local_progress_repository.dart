import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LocalProgressRepo {
  static String keyForUser(String userId) => 'book_progress_${userId}_v1';

  static Future<Map<String, Map<String, int>>> _loadRaw(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(keyForUser(userId));
    if (raw == null) return {};
    final Map<String, dynamic> decoded = jsonDecode(raw);
    return decoded.map((k, v) => MapEntry(k, Map<String, int>.from(v)));
  }

  static Future<void> _saveRaw(
      String userId, Map<String, Map<String, int>> data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(keyForUser(userId), jsonEncode(data));
  }

  static Future<void> setProgress({
    required String userId,
    required String bookId,
    required int currentPage,
    required int totalPages,
  }) async {
    final data = await _loadRaw(userId);
    data[bookId] = {
      "current": currentPage.clamp(0, totalPages),
      "total": totalPages,
    };
    await _saveRaw(userId, data);
  }

  static Future<double> getPercent({
    required String userId,
    required String bookId,
  }) async {
    final data = await _loadRaw(userId);
    final item = data[bookId];
    if (item == null || (item["total"] ?? 0) == 0) return 0.0;
    final cur = item["current"] ?? 0;
    final tot = item["total"] ?? 0;
    return (cur / tot).clamp(0.0, 1.0);
  }

  static Future<Map<String, double>> getAllPercents(String userId) async {
    final data = await _loadRaw(userId);
    return data.map((id, v) {
      final tot = v["total"] ?? 0;
      final cur = v["current"] ?? 0;
      final p = tot == 0 ? 0.0 : cur / tot;
      return MapEntry(id, p.clamp(0.0, 1.0));
    });
  }

  static Future<void> clearBook(
      {required String userId, required String bookId}) async {
    final data = await _loadRaw(userId);
    data.remove(bookId);
    await _saveRaw(userId, data);
  }
}
