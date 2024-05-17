import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/task.dart';
import 'package:http/http.dart' as http;


class TaskProvider with ChangeNotifier {
  ApiService _apiService = ApiService();
  List<Task> _tasks = [];
  String _token = '';

  List<Task> get tasks => _tasks;
  String get token => _token;

  void setToken(String token) {
    _token = token;
  }

  Future<void> login(String email, String password) async {
    var response = await _apiService.login(email, password);
    _token = response['token'];
    notifyListeners();
  }

  Future<void> logout() async {
    await _apiService.logout(_token);
    _token = '';
    _tasks = [];
    notifyListeners();
  }

  Future<List<Task>> fetchTasks() async {
    _tasks = await _apiService.getTasks(_token);
    notifyListeners();
    return _tasks;
  }

  Future<void> register(String name, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:8000/api/register'),
        body: {
          'name': name,
          'email': email,
          'password': password,
          'password_confirmation': password,
        },
      );

      if (response.statusCode == 201) {
        print('Registration successful');
      } else {
        print('Registration failed');
      }
    } catch (error) {
      print('Error: $error');
      throw error;
    }
  }

  Future<void> createTask(String title) async {
    await _apiService.createTask(title, _token);
    fetchTasks();
  }

  Future<void> updateTask(int id, String title) async {
    await _apiService.updateTask(id, title, _token);
    fetchTasks();
  }

  Future<void> deleteTask(int id) async {
    await _apiService.deleteTask(id, _token);
    fetchTasks();
  }
}
