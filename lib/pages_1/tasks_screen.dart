import 'package:flutter/material.dart';

class TasksScreen extends StatelessWidget {
  final String taskName;
  final bool taskcompleted;

  const TasksScreen({
    super.key,
    required this.taskName,
    required this.taskcompleted,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      appBar: AppBar(
        title: const Text("Task of the day"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Task: $taskName',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              taskcompleted ? "Status: Completed " : "Status: Incomplete ",
              style: TextStyle(
                fontSize: 18,
                color: taskcompleted ? Colors.green : Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
