/* This is the core of Week 3. It combines UI structuring, state management, 
   persistent storage, and the required features (add, delete, complete) into 
   one cohesive screen. */

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task_model.dart'; // --> Importing our custom model

class TaskHomeScreen extends StatefulWidget {
  const TaskHomeScreen({super.key});

  @override
  State<TaskHomeScreen> createState() => _TaskHomeScreenState();
}

class _TaskHomeScreenState extends State<TaskHomeScreen> {
  List<Task> _tasks = [];
  static const String TASKS_KEY = "saved_tasks";

  @override
  void initState() {
    super.initState();
    _loadTasks(); // --> Load tasks when the app opens
  }

  // --- DATA MANAGEMENT METHODS ---

  void _loadTasks() async {
    var sharedPref = await SharedPreferences.getInstance();
    List<String>? savedTasks = sharedPref.getStringList(TASKS_KEY);

    if (savedTasks != null) {
      setState(() {
        // --> Converting the saved JSON strings back into Task objects
        _tasks = savedTasks.map((taskStr) => Task.fromJson(taskStr)).toList();
      });
    }
  }

  void _saveTasks() async {
    var sharedPref = await SharedPreferences.getInstance();
    // --> Converting the Task objects into JSON strings to save them
    List<String> tasksAsStrings = _tasks.map((task) => task.toJson()).toList();
    sharedPref.setStringList(TASKS_KEY, tasksAsStrings);
  }

  // --- TASK ACTIONS ---

  void _addTask(String title) {
    if (title.isNotEmpty) {
      setState(() {
        _tasks.add(Task(title: title)); // --> Defaults to isCompleted = false
      });
      _saveTasks();
    }
  }

  void _toggleComplete(int index) {
    setState(() {
      _tasks[index].isCompleted = !_tasks[index].isCompleted; // --> Flips the boolean
    });
    _saveTasks();
  }

  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
    _saveTasks();
  }

  // --- UI METHODS ---

  // --> A function to show a dialog box for adding tasks
  void _showAddTaskDialog() {
    var taskController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add New Task"),
          content: TextField(
            controller: taskController,
            decoration: InputDecoration(
              hintText: "What do you need to do?",
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.blue.shade700, width: 2),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: Colors.grey, width: 2),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), // --> Close dialog
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                _addTask(taskController.text.trim());
                Navigator.pop(context); // --> Close dialog after adding
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // --> Custom App Bar with an Action Button as requested in the document
      appBar: AppBar(
        backgroundColor: Colors.blue.shade600,
        titleTextStyle: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold, color: Colors.white),
        title: const Text("My Tasks"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_task, color: Colors.white),
            onPressed: _showAddTaskDialog, // --> Triggers the dialog box
          ),
        ],
      ),
      body: _tasks.isEmpty
          ? const Center(child: Text("All caught up! Add a new task.", style: TextStyle(fontSize: 18)))
          : ListView.separated(
              itemCount: _tasks.length,
              separatorBuilder: (context, index) => const Divider(height: 1, thickness: 1),
              itemBuilder: (context, index) {
                var currentTask = _tasks[index];

                return ListTile(
                  // --> Using the Icons library for visual appeal
                  leading: IconButton(
                    icon: Icon(
                      currentTask.isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
                      color: currentTask.isCompleted ? Colors.green : Colors.grey,
                    ),
                    onPressed: () => _toggleComplete(index),
                  ),
                  title: Text(
                    currentTask.title,
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w500,
                      // --> Adds a strikethrough effect if the task is complete
                      decoration: currentTask.isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
                      color: currentTask.isCompleted ? Colors.grey : Colors.black,
                    ),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.redAccent),
                    onPressed: () => _deleteTask(index),
                  ),
                );
              },
            ),
      // --> A Floating Action Button as a secondary, easy way to add tasks
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog,
        backgroundColor: Colors.blue.shade600,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
