import 'package:adt2/firestore/database.dart';
import 'package:flutter/material.dart';

import '../tools/dialog_box.dart';
import 'package:adt2/tools/todo_tile.dart'; 
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ToDoDataBase db = ToDoDataBase();

  final TextEditingController _controller = TextEditingController();

  bool _isLoading = true; 

  List<Map<String, dynamic>> _toDoList = []; 

  @override
  void initState() {
    super.initState();

    _loadData(); 
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true; 
    });

    final tasks = await db.getTasks(); 

    setState(() {
      _toDoList = tasks; 

      _isLoading = false; 
    });
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  void saveNewTask() async {
    if (_controller.text.isNotEmpty) {
      await db.addTask(_controller.text); 

      _controller.clear();

      Navigator.of(context).pop();

      await _loadData(); 
    }
  }

  void checkBoxChanged(String id, bool? value) async {
    

    await db.toggleTaskCompletion(id, value ?? false);

    

    setState(() {
      final taskIndex = _toDoList.indexWhere((task) => task['id'] == id);

      if (taskIndex != -1) {
        _toDoList[taskIndex]['completed'] = value ?? false;
      }
    });
  }

  void deleteTask(String id) async {
    await db.deleteTask(id); 

    await _loadData(); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 41, 3, 48),
        centerTitle: true,
        title: const Text(
          '7OS ToDo No.18',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        elevation: 200,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: const Icon(Icons.add),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _toDoList.length,
              itemBuilder: (context, index) {
                final task = _toDoList[index];

                return ToDoTile(
                  taskName: task['task'],
                  taskCompleted: task['completed'],
                  onChanged: (value) => checkBoxChanged(task['id'], value),
                  deleteFunction: (context) => deleteTask(task['id']),
                );
              },
            ),
    );
  }
}
