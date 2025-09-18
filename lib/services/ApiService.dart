import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl =
      "http://127.0.0.1:8000"; // ganti IP kalau di emulator/device

  // --- Store APIs ---
  static Future<List<dynamic>> getStores() async {
    final res = await http.get(Uri.parse("$baseUrl/stores"));
    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else {
      throw Exception("Failed to load stores");
    }
  }

  static Future<Map<String, dynamic>> createStore(
    Map<String, dynamic> data,
  ) async {
    final res = await http.post(
      Uri.parse("$baseUrl/stores"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(data),
    );
    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else {
      throw Exception("Failed to create store");
    }
  }

  static Future<Map<String, dynamic>> updateStore(
    int id,
    Map<String, dynamic> data,
  ) async {
    final res = await http.put(
      Uri.parse("$baseUrl/stores/$id"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(data),
    );
    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else {
      throw Exception("Failed to update store");
    }
  }

  static Future<void> deleteStore(int id) async {
    final res = await http.delete(Uri.parse("$baseUrl/stores/$id"));
    if (res.statusCode != 200) {
      throw Exception("Failed to delete store");
    }
  }

  // --- Collection APIs ---
  static Future<List<dynamic>> getCollections() async {
    final res = await http.get(Uri.parse("$baseUrl/collections"));
    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else {
      throw Exception("Failed to load collections");
    }
  }

  static Future<Map<String, dynamic>> createCollection(
    Map<String, dynamic> data,
  ) async {
    final res = await http.post(
      Uri.parse("$baseUrl/collections"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(data),
    );
    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else {
      throw Exception("Failed to create collection");
    }
  }

  static Future<Map<String, dynamic>> updateCollection(
    int id,
    Map<String, dynamic> data,
  ) async {
    final res = await http.put(
      Uri.parse("$baseUrl/collections/$id"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(data),
    );
    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else {
      throw Exception("Failed to update collection");
    }
  }

  static Future<void> deleteCollection(int id) async {
    final res = await http.delete(Uri.parse("$baseUrl/collections/$id"));
    if (res.statusCode != 200) {
      throw Exception("Failed to delete collection");
    }
  }
}
