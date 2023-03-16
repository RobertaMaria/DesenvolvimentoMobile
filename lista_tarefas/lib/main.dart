import 'package:flutter/material.dart';

void main() {
  runApp(const TaskList());
}

class TaskList extends StatelessWidget {
  const TaskList({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _taskController = TextEditingController();

  List<Task> _taskList = [];

  Future<List<Task>> getData() {
    return Future.value(_taskList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Tarefas"),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(17.0, 1.0, 7.0, 1.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                      controller: _taskController,
                      decoration: InputDecoration(
                        labelText: "Nova Tarefa",
                        labelStyle: TextStyle(color: Colors.blueAccent),
                      )),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      final String title = _taskController.text;
                      if (title.isNotEmpty) {
                        final taskCreated = Task(title);
                        _taskList.add(taskCreated);
                        _taskController.text = "";
                      }
                    });
                  },
                  child: const Text(
                    "ADD",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder()),
                )
              ],
            ),
          ),
          Expanded(
              child: ListView.builder(
            padding: EdgeInsets.only(top: 10.0),
            itemCount: _taskList.length,
            itemBuilder: (context, index) {
              final task = _taskList[index];
              return TaskItem(task: Task(task.title));
            },
          ))
        ],
      ),
    );
  }
}

class TaskItem extends StatelessWidget {
  const TaskItem({super.key, required this.task});

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          child: Icon(Icons.error),
        ),
        title: Text(task.title),
      ),
    );
  }
}

class Task {
  final String title;

  Task(this.title);

  @override
  String toString() {
    return 'Task{title: $title}';
  }
}
