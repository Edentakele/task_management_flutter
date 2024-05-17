class Task {
  final int id;
  final String title;
  final int userId;

  Task({required this.id, required this.title, required this.userId});

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      userId: json['user_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'user_id': userId,
    };
  }
}
