import 'dart:convert';
import 'package:http/http.dart' as http;
import 'models/task.dart';

class ApiService {
  final String baseUrl = 'http://localhost:8000/api'; // Adjust this based on your Laravel setup

  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email, 'password': password}),
    );
    return json.decode(response.body);
  }

  Future<void> logout(String token) async {
    await http.post(
      Uri.parse('$baseUrl/logout'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
  }

  Future<List<Task>> getTasks(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/tasks'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    Iterable list = json.decode(response.body);
    return list.map((task) => Task.fromJson(task)).toList();
  }
}
