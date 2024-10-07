import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TaskListScreen(),
    );
  }
}

class Task {
  final String name;
  final String priority;

  Task({required this.name, required this.priority});
}

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final List<Task> _tasks = [];
  final TextEditingController _taskController = TextEditingController();
  String _selectedPriority = 'Low';

  void _addTask() {
    setState(() {
      _tasks.add(Task(name: _taskController.text, priority: _selectedPriority));
      _taskController.clear();
    });
  }

  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Set background color to black
      appBar: AppBar(
        title: Text('Task List'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _taskController,
              decoration: InputDecoration(
                hintText: 'Search...',
                hintStyle: TextStyle(color: Colors.black), // Hint text color
                filled: true,
                fillColor: Colors.white, // Search bar color
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none, // Remove border
                ),
              ),
              style: TextStyle(color: Colors.black), // Text color in search bar
            ),
            SizedBox(height: 20),
            // Dropdown for selecting priority
            Container(
              decoration: BoxDecoration(
                color: Colors.white, // Dropdown background color
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: DropdownButton<String>(
                value: _selectedPriority,
                items: ['Low', 'Medium', 'High'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value, style: TextStyle(color: Colors.black)), // Dropdown text color
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedPriority = newValue!;
                  });
                },
                underline: SizedBox(), // Remove underline
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addTask,
              child: Text('Add Task'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white, // Button color
                foregroundColor: Colors.black, // Button text color
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _tasks.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      _tasks[index].name,
                      style: TextStyle(color: Colors.white), // Task text color
                    ),
                    subtitle: Text(
                      'Priority: ${_tasks[index].priority}',
                      style: TextStyle(color: Colors.white54), // Subtitle text color
                    ),
                    trailing: ElevatedButton(
                      onPressed: () => _deleteTask(index),
                      child: Text('Delete'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white, // Delete button background color
                        foregroundColor: Colors.black, // Delete button text color
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
