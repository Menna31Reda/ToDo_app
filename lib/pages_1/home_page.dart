import 'dart:convert';

import 'package:app/config/preferences.dart';
import 'package:app/pages_1/tasks_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app/utils_1/todo_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = TextEditingController();
  List toDolist = [];
  bool? taskcompleted;
  final sp = SharedPreferences.getInstance();

  void onChanged(int index) {
    setState(() {
      toDolist[index][1] = !toDolist[index][1];
    });
    Preference.setBool("taskcompleted", toDolist[index][1]);
  }

  void saveNewTask() async {
    if (_controller.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please enter a task',
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 16),
          ),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }
    setState(() {
      toDolist.add([_controller.text, false]);
      _controller.clear();
    });
  }

  void setToDOlist() async {
    List<Map<String, dynamic>> todoMapList = toDolist
        .map((item) => {
              'task': item[0],
              'completed': item[1],
            })
        .toList();
    String encodedList = json.encode(todoMapList);
    await Preference.setString("toDolist", encodedList);
  }

  void deleteTask(int index) {
    setState(() {
      toDolist.removeAt(index);
    });
  }

  getSharedPreferences() async {
    String? encodedList = Preference.getString("toDolist");
    if (encodedList != null) {
      List<dynamic> decodedList = json.decode(encodedList);
      setState(() {
        toDolist = decodedList
            .map((item) => [
                  item['task'],
                  item['completed'],
                ])
            .toList();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getSharedPreferences();
    Preference.getBool("taskcompleted");
  }

  @override
  Widget build(BuildContext context) {
    setToDOlist();
    return Scaffold(
      backgroundColor: Colors.deepPurple[300],
      appBar: AppBar(
        title: const Text('todo app'),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView.builder(
        itemCount: toDolist.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TasksScreen(
                    taskName: toDolist[index][0],
                    taskcompleted: toDolist[index][1],
                  ),
                ),
              );
            },
            child: TodoList(
              taskName: toDolist[index][0],
              taskcompleted: toDolist[index][1],
              onChanged: (value) async {
                onChanged(index);
              },
              deleteFunction: (context) => deleteTask(index),
            ),
          );
        },
      ),
      floatingActionButton: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Enter your task',
                  filled: true,
                  fillColor: Colors.deepPurple,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple.shade200),
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
            ),
          ),
          FloatingActionButton(
            onPressed: saveNewTask,
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
