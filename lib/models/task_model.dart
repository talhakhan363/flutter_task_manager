// Unlike Week 2 where we saved simple strings, here we need to save a task's title and its completion status. We create a model to handle this easily.

import 'dart:convert';

// --> Creating a custom class to represent a single Task
class Task {
  String title;
  bool isCompleted;

  Task({required this.title, this.isCompleted = false});

  // --> Converts the Task object into a Map so it can be saved in SharedPreferences
  Map<String, dynamic> toMap() {
    return {'title': title, 'isCompleted': isCompleted};
  }

  // --> Rebuilds the Task object from a Map when retrieving from SharedPreferences
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(title: map['title'], isCompleted: map['isCompleted']);
  }

  // --> Helper function to encode a Task to a JSON string
  String toJson() => json.encode(toMap());

  // --> Helper function to decode a JSON string back to a Task
  factory Task.fromJson(String source) => Task.fromMap(json.decode(source));
}
