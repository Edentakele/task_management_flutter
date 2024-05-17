import 'package:flutter/material.dart';
import '../api_service.dart';
import '../models/task.dart';
import 'package:http/http.dart' as http;


class TaskProvider with ChangeNotifier {
  ApiService _apiService = ApiService();
  List<Task> _tasks = [];
  String _token = '';

  List<Task> get tasks => _tasks;
  String get token => _token;

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

  Future<void> fetchTasks() async {
    _tasks = await _apiService.getTasks(_token);
    notifyListeners();
  }

  Future<void> register(String name, String email, String password) async {
    try {
      // Make HTTP request to register user
      final response = await http.post(
        Uri.parse('http://127.0.0.1:8000/api/register'), // Replace with your API endpoint
        body: {
          'name': name,
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 201) {
        // Registration successful
        // You can handle success as per your app's requirement
        print('Registration successful');
      } else {
        // Registration failed
        // You can handle failure as per your app's requirement
        print('Registration failed');
      }
    } catch (error) {
      // Handle error
      print('Error: $error');
      throw error; // Rethrow error for handling in UI
    }
  }
}
