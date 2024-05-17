import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TaskListScreen extends StatefulWidget {
  final String token;

  TaskListScreen({required this.token});

  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  List<String> _tasks = [];

  Future<void> _fetchTasks(String token) async {
    final String apiUrl = 'http://127.0.0.1:8000/api/tasks';
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      setState(() {
        _tasks = responseData.map<String>((task) => task['title'].toString()).toList();
      });
    } else {
      // Handle error
      print('Failed to fetch tasks: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchTasks(widget.token); // Pass the token received from the constructor
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task List'),
      ),
      body: ListView.builder(
        itemCount: _tasks.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_tasks[index]),
          );
        },
      ),
    );
  }
}
